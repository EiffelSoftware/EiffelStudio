#!/bin/bash

echo "ec -finalize -c_compile -config ejson_test.ecf > /dev/null 2>&1"
ec -finalize -c_compile -config ejson_test.ecf > /dev/null 2>&1
cp EIFGENs/ejson_test/F_code/ejson_test .
