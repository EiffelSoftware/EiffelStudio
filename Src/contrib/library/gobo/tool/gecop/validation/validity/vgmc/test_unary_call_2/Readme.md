# Validity VGMC

This [test](.) is exercising the validity rule [VGMC](../Readme.md).

### Description

In this test, the formal generic parameter `G` of class `BB` has two constraints `CC` and `DD`. There is a call `+ a` where `a` is of type `G`. But the unary operator `+` is the alias name of a feature both in `CC` and `DD`. This violates `VGMC`.

### Notes

* ISE Eiffel (as of 18.11.10.2592 and after) reports this validity rule violation using the old code `VTMC-2`. Also, the error message mentions `prefix "+"`, but there is not such feature name in the code. The code uses `alias "+"`.
