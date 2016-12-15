import os
import re
import time
from slackclient import SlackClient


class Chefbot(object):
    # Bot constants
    BOT_NAME = 'chefbot'
    API_TOKEN = os.environ.get('CHEFBOT_TOKEN')
    BOT_ID = os.environ.get('CHEFBOT_ID')
    AT_BOT = '<@' + BOT_ID + '>'

    # Delay in seconds
    websocket_delay = 1

    def __init__(self):
        self.slack_client = SlackClient(self.API_TOKEN)

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
                
                self.parse_messages(messages)

                time.sleep(self.websocket_delay)
        else:
            raise Exception('Could not connect to Slack RTM API')

    def parse_messages(self, messages):
        for message in messages:
            if re.search('schedule', message, re.IGNORECASE):
                # Scheduling functions
                pass
            else:
                # List functions
                pass

    def add_to_list(self):
        # Add item to list
        # TODO: list different ingredient options including word
        pass

    def delete_from_list(self):
        # Delete item/quantity from list
        pass

    def truncate_list(self):
        # Delete shopping list
        pass

    def export_list(self):
        # Compile list into pdf
        pass

    def schedule_recipe(self):
        # Add recipe to schedule
        pass

    def unschedule_recipe(self):
        # Remove recipe from schedule
        # Optionally subtract from shopping list
        pass

    def reset_schedule(self):
        # Truncate schedule
        pass

if __name__ == "__main__":
    with Chefbot() as chef:
        chef.listen()
