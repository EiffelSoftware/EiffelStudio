Comments on testerr.
This test tests the error history and part of NAG_EXCEPTIONS.
It does this by using class FAKE_NAG_ERROR which simulates the
condition of NAG_ERROR after a NAG Library error.

The output should match esession.log. If you have melted the program,
one exception will occur; you should click "run" to allow it to be 
rescued.
