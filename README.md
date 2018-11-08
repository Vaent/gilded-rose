# Gilded Rose Project

To view the source material for this project please refer to https://github.com/makersacademy/gilded_rose_design_project or the following commit in this repo: [a048f3]https://github.com/Vaent/gilded-rose/tree/a048f373f5818ae33f3c6e96c404f35709092b1d

## Background

The Gilded Rose is a tavern which sells a range of items.

The majority of the items stocked deteriorate in quality each day, with the rate of deterioration doubling after they pass their sell-by date.

Exceptions to the general rule above include items which never decay, items which improve in quality over time, and items which have additional caveats to the rate of deterioration/appreciation.

There are also upper and lower limits to item quality which must be taken into account.

A program had been set up to record the inventory and automatically update the quality of each item at the end of every day. The tavern is now expanding its range and so the program needs updating.

## Actions taken

The original code, although it met all the original requirements, was structured in such a manner that the purpose and effect of individual elements were not clear. I therefore began by refactoring it to expose and consolidate the functionality.

A suite of unit tests had been provided; these were retained as they provided complete coverage for the initial spec, with very little modification required. The tests were run regularly to ensure bugs were caught and fixed as early as possible.

Once sufficient clarity had been gained, a new type of item was incorporated. Achieving this was trivial due to the prior restructuring.

I then refactored again following feedback from a coach at Makers Academy, extracting most of the methods from the 'GildedRose' class and rehoming them in a new class/subclass structure inheriting from the basic 'Item' class, to better reflect their relevance and the synergy between program objects.
