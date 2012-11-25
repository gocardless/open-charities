# Open Charities

A simple library for querying http://opencharities.org/ database.

I have used Tom's Open Companies House gem as a sort of template for this gem,
mainly because it's all quite new to me. The code is scarily similar to Tom's gem,
but some feedback would be awesome.

I learnt about Ruby's metaprogramming and I tried using it in `lib/open\_charities/response.rb`
to convert the top-level keys in the returned JSON into singleton methods on the charity
instance. Feedback on that is greatly appreciated.
