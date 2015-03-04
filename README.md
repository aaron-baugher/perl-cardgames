# perl-cardgames
Card Games in Perl

This is a project I started several years ago and then forgot about.  I was
creating an OO basis for card games, which I could then use to write various
solitaire or multi-person games, as well as solvers.  So far, all I finished
was a single solver, but the underlying objects work, so anyone is welcome
to use them.

The single solver, called "patience," is for a simple solitaire game.  You
deal the cards face-up four at a time into four piles, one card each.  After
each deal, if the four cards showing are of the same rank (four kings, for
instance), remove those four cards.  The goal is to remove all 13 sets of
four.  If you deal out all the cards without winning, pick up the piles one
at a time into a stack without shuffling, and try again.

Wins are very rare.  This program tries up to 200 full deals, then gives up,
because deals often reach a point where cards are just shifting back and
forth between two piles without ever changing anything, and the game is
stuck.  It might be useful to add some code to detect that.

Very much still a work in progress.

