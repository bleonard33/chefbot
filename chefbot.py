import os
import time
import psycopg2
import queries
from slackclient import SlackClient


class DBConnection(object):
    
    def __init__(self):
        self.conn = psycopg2.connect("dbname=postgres user=bleonard")
        self.cursor = self.conn.cursor()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        self.quit()

    def quit(self):
        self.cursor.close()
        self.conn.close()


class Recipe(object):
    pass


class Schedule(object):
    pass


# class Ingredient(object):
#     pass


class Chefbot(object):
    # Bot constants
    BOT_NAME = 'chefbot'

    # Delay in seconds
    WEBSOCKET_DELAY = 1

    def __init__(self):
        self.API_TOKEN = os.environ.get('CHEFBOT_TOKEN')
        self.BOT_ID = os.environ.get('CHEFBOT_ID')
        self.AT_BOT = '<@' + self.BOT_ID + '>'
        self.slack_client = SlackClient(self.API_TOKEN)
        self.db = DBConnection()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        self.db.quit()

    def execute(self, query):
        self.cursor.execute(query)
        self.conn.commit()

    def listen(self):
        # Listen to messages from the slack RTM API
        if self.slack_client.rtm_connect():
            while True:
                # Check if object is a message with @chefbot
                # TODO: Check if message is in a DM
                messages = [x for x
                                in self.slack_client.rtm_read()
                                if x['type'] == 'message' and
                                    self.AT_BOT in x['text']]

                for message in messages:
                    # TODO: put this in a try/except
                    # try:
                    self.parse_messages(message)
                    # except Exception as e:
                    #     self.slack_client.api_call(
                    #         "chat.postMessage",
                    #         channel=message['channel'],
                    #         text='Whoops! Something went wrong: {}'.format(e),
                    #         as_user=True)

                time.sleep(self.WEBSOCKET_DELAY)
        else:
            raise Exception('Could not connect to Slack RTM API')

    def parse_messages(self, message):

        text = message['text'].split(' ')

        if 'add' in text:
            response = self.add_to_list(text)

        self.slack_client.api_call(
            "chat.postMessage",
            channel=message['channel'],
            text=response,
            as_user=True)

    def add_to_list(self, text):
        # Add items to list
        # TODO: list different ingredient options including word

        # Purge everything before "add" and after "to"
        text = text[text.index('add') + 1:]
        if 'to' in text:
            text = text[:text.index('to')]

        # See if quantity is given, else assume 1 unit
        try:
            quantity = float(text[0])
            text.pop(0)
        except ValueError:
            quantity = 1

        item = ' '.join(text)

        self.cursor.execute(queries.CHECK_ITEM_TEXT.format(item))
        ing_results = self.cursor.fetchall()

        if len(ing_results) == 0:
            return 'I\'m not sure what that is. Try again.'
        elif len(ing_results) == 1:

            ing_id, ing_name, ing_unit = ing_results[0]

            self.execute(queries.ADD_TO_LIST.format(
                ingredient_id=ing_id, amount=quantity))

            return ('Okay! I\'ve added {} {} {} to the list'.format(
                quantity, ing_unit, ing_name))

        else:
            # TODO: need more information to decide which item to add
            pass

    def delete_from_list(self, item, quantity):
        # Delete item/quantity from list
        pass

    def get_ingredient_id(self, ingredient):
        # Find out correct ingredient id and confirm
        pass

    def new_ingredient(self, ingredient):
        pass

    def reset_list(self):
        # Truncate shopping list
        self.execute(queries.RESET_LIST)

    def export_list(self):
        # Compile list into sorted post
        # TODO: Export PDF
        pass

    def schedule_recipe(self, recipe, day, add=True):
        # Add recipe to schedule
        # Optionally add ingredients to shopping list
        # e.g., '@chefbot schedule pasta for monday'
        pass

    def unschedule_recipe(self, recipe, day=None, subtract=False):
        # Remove recipe from schedule
        # Optionally subtract all from shopping list
        # e.g., '@chefbot unschedule monday', '@chefbot unschedule pasta'
        pass

    def reset_schedule(self):
        # Truncate schedule table
        self.execute(queries.RESET_SCHEDULE)

    def help(self):
        # Return help text with available commands
        pass

    def parse_unit(self, message):
        overlap = set(message) & set(self.units)

        if len(overlap) > 0:
            return list(set(message) & set(self.units))[0]

if __name__ == "__main__":

    with Chefbot() as chef:
        chef.listen()
