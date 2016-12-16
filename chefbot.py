import os
import re
import time
import psycopg2
import queries
from slackclient import SlackClient


class DBConnection(object):
    conn = psycopg2.connect("dbname=postgres user=bleonard")
    cursor = conn.cursor()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        self.quit()

    def quit(self):
        self.cursor.close()
        self.conn.close()       


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

        self.db.cursor.execute(queries.UNIT_QUERY)
        self.units = [x[0] for x
                            in self.db.cursor.fetchall()
                            if x[0] != '']

        print self.units

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        self.db.quit()

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
                    self.parse_messages(message)

                time.sleep(self.WEBSOCKET_DELAY)
        else:
            raise Exception('Could not connect to Slack RTM API')

    def parse_messages(self, message):

        text = message['text'].split(' ')

        if 'add' in text:
            # Purge everything before "add" and after "to"
            text = text[text.index('add') + 1:]
            if 'to' in text:
                text = text[:text.index('to')]

            unit = self.parse_unit(text)
            print unit

    def add_to_list(self, item, quantity, unit):
        # Add items to list
        # TODO: list different ingredient options including word
        pass

    def delete_from_list(self, item, quantity):
        # Delete item/quantity from list
        pass

    def truncate_list(self):
        # Delete shopping list
        pass

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
        # Truncate schedule
        pass

    def help(self):
        # Return help text with available commands
        pass

    def parse_unit(self, message):
        overlap = set(message) & set(self.units)
        
        if len(overlap) > 0:
            return list(set(message) & set(self.units))[0]

    @staticmethod
    def get_ingredient_id(ingredient):
        # Find out correct ingredient id and confirm
        pass

if __name__ == "__main__":

    with Chefbot() as chef:
        chef.listen()
