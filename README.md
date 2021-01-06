# Currency spike

This is a mental exercise based on a real-life project I have been discussing at work. What we want to build is a payment scheme based on real and virtual currencies. A user of the service has a wallet he can use to pay for goods at various places backed by different kinds of funds deposited in the account.

The deposits can be either "real" cash, gifts, points earned on purchases and anything else really. 

This looks like a great case for a blockchain based system where the value of each deposit can vary based on various things:

- Points earned in a store will have a different value if used in the same store or another store (or maybe have a zero value in other stores)
- The value of one deposit may change more over time than others
- A deposit may have a time-limited validity, or decrease incrementally over time

A blockchain would offer a completely dynamic valuation of the different funds over time. But rather than start with the hammer and then look around for nails, let's start with the basics.

## A naïve implementation with a simple API

I *know* that the implementation of things like the "currency" exchange mechanism is going to be hard to get right. And still I need code to get started, and I would rather start our with the simplest thing that could possibly work. So my ambition is to have an implementation I know is too simplistic, but at the same time I want the API surface to be clean. So I have started with a naïve implementation (which I know now is never going into production) with a clean API (which doesn't make any assumptions I know are going to fail).

The current implementation of calculating the value of different funds is simply a Hash with a factor for each currency. But the API for crosses can hopefully remain unchanged for a long time.

The best way to read the code is to read [the test suite](account_test.rb).