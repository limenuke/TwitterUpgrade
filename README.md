# Project 3 - TwitterApp

TwitterApp is a basic twitter app to read and compose tweets from the [Twitter API](https://apps.twitter.com/).

Time spent: **22** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow.
- [x] User can view last 20 tweets from their home timeline.
- [x] The current signed in user will be persisted across restarts.
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Make touches in the cell specific to certain parts of the cell? I only had the text responding to touches.
2. Cleaner use of delegates/notifications/segues to share data.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/X8zB0ts.gif' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Didn't know about favorites_count in main tweet object representing the actual favorites count as opposed to using the user favourites_count
- Lots of issues using segues and pushing them with data
- Wish I had more time to get icons for favoriting/unfavoriting
- Thoroughly enjoyed making this, but just wish I had more time to do it.

## License

    Copyright [2016] [Mark Shen]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.