#!/usr/bin/python3
"""
Queries the Reddit API and returns the number of subscribers for a given subreddit.
"""

import requests


def number_of_subscribers(subreddit):
    """
    Returns the number of subscribers for a given subreddit.

    Args:
        subreddit: A string representing the subreddit name.

    Returns:
        The number of subscribers if the subreddit is valid, otherwise 0.
    """
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {"User-Agent": "Mozilla/5.0"}  # Set a custom User-Agent to prevent 429 error
    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        data = response.json()
        subscribers = data['data']['subscribers']
        return subscribers
    else:
        return 0


if __name__ == "__main__":
    subreddit = input("Enter the subreddit name: ")
    print(number_of_subscribers(subreddit))

