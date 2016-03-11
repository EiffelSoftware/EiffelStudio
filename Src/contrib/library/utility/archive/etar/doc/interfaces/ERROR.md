**[Home](../README.md) | [Interfaces](README.md) | [Index](../index.md)**
***

Parts of the etar library may report errors (mostly caused by corrupted files). This page shortly explains how error reporting works and how you can register your own callback that is called in case of an error.

### ERROR

Each `ERROR` object has a message and an optional parent (used for generating traces). They can be created by either using `make` or `make_with_parent`.

### ERROR_HANDLER

Error handlers allow to report errors and to register arbitrary callbacks that are called when errors are reported. In etar, all classes that may report errors inherit from `ERROR_HANDLER` and report the errors using `report_error`, `report_new_error` or `report_error_with_parent`. If an attribute of a new class may report errors, the class should inherit form `ERROR_HANDLER` as well and register itself as a callback:

(from `ARCHIVE.default_create`)
```
header_parser.register_error_callback (agent report_error_with_parent ("Header parser failed", ?))
storage_backend.register_error_callback (agent report_error_with_parent ("Storage backend failed", ?))
```

Like this errors cascade and generate a trace, which makes it easy to find out, where the error was reported.

#### Reporting Errors
Probably the most comfortable way to report errors is `ERROR_HANDLER.report_new_error`, which will simply generate an `ERROR` for a given error message and report it. In case you want to build the `ERROR` object yourself, you can use `report_error` and if you want to automatically add a parent to a new error, you might want to use `report_error_with_parent`.

#### Error Listening

To listen to error that occur, one can register a callback using `ERROR_HANDLER.register_error_callback`. One of the most simple examples (using `LOCALIZED_PRINTER`):

```
print_error (a_error: ERROR)
        -- Print error to stderr
    do
        localized_print_error (a_error.string_representation)
    end
```

and register this as callback:

```
some_error_handler.register_error_callback (agent print_error (?))
```
***
**[Back to the index](../index.md)**

