RubyPoker
=========

Simple implementation of a Poker simulator

- Given a single poker hand, returns it's rank (see details of ranks below) 
- Given 2 poker hands as input, compares them and return a result indicating which hand, if any, is the highest


### Poker rules description

A poker deck contains 52 cards - each card has a suit which is one of clubs, diamonds, hearts, or spades (denoted C, D, H, and S in the input data). Each card also has a value which is one of 2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace (denoted ). For scoring purposes, the suits are unordered while the values are ordered as given above, with 2 being the lowest and ace the highest value.

You may find it helpful to denote the values with 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A and the suits with C, D, H, and S, i.e. 2C is the two of clubs and QS is the queen of spades.

A poker hand consists of 5 cards dealt from the deck. Poker hands are ranked by the following partial order from lowest to highest.

1. High Card: Hands which do not fit any higher category are ranked by the value of their highest card. If the highest cards have the same value, the hands are ranked by the next highest, and so on.

2. Pair: 2 of the 5 cards in the hand have the same value. Hands which both contain a pair are ranked by the value of the cards forming the pair. If these values are the same, the hands are ranked by the values of the cards not forming the pair, in decreasing order.

3. Two Pairs: The hand contains 2 different pairs. Hands which both contain 2 pairs are ranked by the value of their highest pair. Hands with the same highest pair are ranked by the value of their other pair. If these values are the same the hands are ranked by the value of the remaining card.

4. Three of a Kind: Three of the cards in the hand have the same value. Hands which both contain three of a kind are ranked by the value of the 3 cards.

5. Straight: Hand contains 5 cards with consecutive values. Hands which both contain a straight are ranked by their highest card.

6. Flush: Hand contains 5 cards of the same suit. Hands which are both flushes are ranked using the rules for High Card.

7. Full House: 3 cards of the same value, with the remaining 2 cards forming a pair. Ranked by the value of the 3 cards.

8. Four of a kind: 4 cards with the same value. Ranked by the value of the 4 cards.

9. Straight flush: 5 cards of the same suit with consecutive values. Ranked by the highest card in the hand.


### Command line options

* hand  <str1> <str2> - play hands with two formatted string
* shuffle             - play random hands
* holdem              - play holdem with 7 cards
* test                - rankings tests
* help                - this help (default)