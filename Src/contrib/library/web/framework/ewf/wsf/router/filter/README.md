# Introduction

The basic idea of a filter is to pre-process incoming data and post-process outgoing data.
Filters are part of a filter chain, thus following the [chain of responsability design pattern](http://en.wikipedia.org/wiki/Chain-of-responsibility_pattern).

Each filter decides to call the next filter or not.

# Levels

In EWF, there are two levels of filters.

## WSF_FILTER

Typical examples of such filters are: logging, compression, routing (WSF_ROUTING_FILTER), ...

## WSF_FILTER_HANDLER

Handler that can also play the role of a filter.

Typical examples of such filters are: authentication, ...

# References

Filters (also called middelwares) in other environments:
* in Python: http://www.wsgi.org/en/latest/libraries.html
* in Node.js: http://expressjs.com/guide.html#middleware
* in Apache: http://httpd.apache.org/docs/2.2/en/filter.html
