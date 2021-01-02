PROBLEM TYPE: Syntax
Title: ERROR bad URI `/%%20link%20_posts/0001-01-03-migration
Date: 2020/12/20
Description: 


We were attempting to make relative links to directory _posts so that we could make the portfolio more maintainable. This link


`[_NOTE: This is a continuation of our previous post_](% /_posts/0001-01-03-migration-from-.NET-Core-2.2-to-3.0 %)` 

did not work. We found out from this blog... https://jekyllrb.com/docs/liquid/tags/#linking-to-posts how to make it work by adding this link. 

https://jekyllrb.com/docs/liquid/tags/#linking-to-posts