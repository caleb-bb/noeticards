# Noeticards

## Priorities

1. Enable CRUD operations for cards and decks.
    1. Create database tables for cards and decks
    2. Create contexts and schemas for cards and decks
    3. Write tests
        1. Write a test for adding new decks
        2. Create a factory with function for inserting a deck
        3. Write a test for adding new cards
2. Create liveviews for decks.
    1. Create route
    2. Create controller
    3. Create HEEX template
    4. Write tests
3. Create liveviews for cards
    1. Create files for cards using phx.gen.live with the right args for the different columns of the cards table.
    2. Delete the automatically-generated migration.
    3. Add routes for cards, show, index, new, etc. Remember to add the :deck_id so that it'll be in the params.
    4. Follow the flow of information from "create new card" all the way to the database and back for "view card" "index cards" etc.
4. Create quiz functionality for a given deck.
5. Look into login and user auth (stretch)
