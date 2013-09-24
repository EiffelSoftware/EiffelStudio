Hints to run the ABEL tests in EiffelStudio:

- When executing tests using AutoTest, remember to select the option: Number of tests that can run in parallel: 1
You find this option by clicking the green little arrow in the AutoTest menubar (in the Autotest window) and selecting preferences.

- If a test executed together with others fails, try to execute it alone (this may be due to multi-threading issues of AutoTest)

- If an unexpected error occurs, close EiffelStudio and clean-compile.  

- For the MYSQL tests, write your name and password in PS_MANUAL_TEST_MYSQL at the bottom.

- For SQLite tests, write the file name in PS_MANUAL_TEST_SQLITE.sqlite_file.

Notice that:

- The following tests fail at 25.8.2012 because the corresponding code has not been implemented yet:

-- PS MANUAL TEST IN MEMORY:
--- test object graph read setting
--- test transaction dirty
--- test transaction lost
--- test transaction repeatable read

-- PS MANUAL TEST MYSQL
--- test collections mysql

- The  following tests should pass after uncommenting the retry statement at the end of CRUD_EXECUTOR.handle_error_on_action, but they don't:

-- PS MANUAL TEST MYSQL
--- test transaction cleanup
--- test transaction dirty
--- test transaction lost
--- test transaction repeatable read 

