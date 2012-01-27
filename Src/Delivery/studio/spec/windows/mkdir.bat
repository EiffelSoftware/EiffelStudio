@echo off
rem Script to have a portable way to create directories
if not exist %1 mkdir %1 && echo Creating %1 || echo %1 already exists
@echo on
