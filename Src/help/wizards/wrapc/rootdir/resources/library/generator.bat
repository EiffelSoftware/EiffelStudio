@echo on
title Script to automate WrapC development process.

{if isset="$IS_WINDOWS"}
wrap_c --verbose  {if isset="$C_COMPILE_OPTIONS"}--c_compile_options={$C_COMPILE_OPTIONS/}{/if} --script_pre_process=pre_script.bat --script_post_process=post_script.bat --output-dir=%cd%/generated_wrapper  --full-header={$WIZ.c_library.c_header_location/}  --config=%cd%/config.xml
{/if}

{unless isset="$IS_WINDOWS"}
rem wrap_c --verbose  {if isset="$C_COMPILE_OPTIONS"}--c_compile_options={$C_COMPILE_OPTIONS/}{/if} --script_pre_process=pre_script.bat --script_post_process=post_script.bat --output-dir=%cd%/generated_wrapper  --full-header=%cd%/C/include/{$WIZ.c_library.c_header/}  --config=%cd%/config.xml
{/unless}
