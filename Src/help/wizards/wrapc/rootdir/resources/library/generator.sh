#!/bin/sh
#Script to automate WrapC development process.
{unless isset="$IS_WINDOWS"}
wrap_c --verbose {if isset="$C_COMPILE_OPTIONS"}--c_compile_options={$C_COMPILE_OPTIONS/}{/if} --script_pre_process=pre_script.sh --script_post_process=post_script.sh  --output-dir=./generated_wrapper --full-header={$WIZ.c_library.c_header_location/} --config=config.xml
{/unless}

{if isset="$IS_WINDOWS"}
#wrap_c --verbose {if isset="$C_COMPILE_OPTIONS"}--c_compile_options={$C_COMPILE_OPTIONS/}{/if} --script_pre_process=pre_script.sh --script_post_process=post_script.sh  --output-dir=./generated_wrapper --full-header={$WIZ.c_library.c_header_location/}\{$WIZ.c_library.c_header/} --config=config.xml
{/if}
