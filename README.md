# KVNProgress Bug

This bug occurs if you're showing the success animation behind a UINotification registrar alert view. 

It happens only once since the notifications get registered on the first launch most of the cases, but if your application needs to do some work on first launch, it might get annoying considering almost all users will see it broken.

I will be pushing workarounds to this repo. See other branches.

> **Note:** Buggy behaviours can be seen here: https://www.youtube.com/watch?v=suegxQtywhc 