echo off
setlocal

set T_SRC_DIR=icons
set T_OUTPUT_DIR=..\implementation\images\raw_images


call:BUILD %T_SRC_DIR%\SD_CENTER_CENTER_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_center_center_light_icon.e
call:BUILD %T_SRC_DIR%\SD_CENTER_DOWN_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_center_down_light_icon.e
call:BUILD %T_SRC_DIR%\SD_CENTER_ICON.png  %T_OUTPUT_DIR%\sd_center_icon.e
call:BUILD %T_SRC_DIR%\SD_CENTER_LEFT_ICON.png  %T_OUTPUT_DIR%\sd_center_left_icon.e
call:BUILD %T_SRC_DIR%\SD_CENTER_RIGHT_ICON.png  %T_OUTPUT_DIR%\sd_center_right_icon.e
call:BUILD %T_SRC_DIR%\SD_CENTER_UP_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_center_up_light_icon.e
call:BUILD %T_SRC_DIR%\SD_DOWN_ICON.png  %T_OUTPUT_DIR%\sd_down_icon.e
call:BUILD %T_SRC_DIR%\SD_DOWN_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_down_light_icon.e
call:BUILD %T_SRC_DIR%\SD_FLOATING_TOOL_BAR_ICON.png  %T_OUTPUT_DIR%\sd_floating_tool_bar_icon.e
call:BUILD %T_SRC_DIR%\SD_ICON_MATRIX_10_10.png  %T_OUTPUT_DIR%\sd_icon_matrix_10_10.e
call:BUILD %T_SRC_DIR%\SD_ICON_MATRIX_16_16.png  %T_OUTPUT_DIR%\sd_icon_matrix_16_16.e
call:BUILD %T_SRC_DIR%\SD_ICON_MATRIX_16_8.png  %T_OUTPUT_DIR%\sd_icon_matrix_16_8.e
call:BUILD %T_SRC_DIR%\SD_ICON_MATRIX_32_32.png  %T_OUTPUT_DIR%\sd_icon_matrix_32_32.e
call:BUILD %T_SRC_DIR%\SD_ICON_MATRIX_8_16.png  %T_OUTPUT_DIR%\sd_icon_matrix_8_16.e
call:BUILD %T_SRC_DIR%\SD_LEFT_ICON.png  %T_OUTPUT_DIR%\sd_left_icon.e
call:BUILD %T_SRC_DIR%\SD_LEFT_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_left_light_icon.e
call:BUILD %T_SRC_DIR%\SD_RIGHT_ICON.png  %T_OUTPUT_DIR%\sd_right_icon.e
call:BUILD %T_SRC_DIR%\SD_RIGHT_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_right_light_icon.e
call:BUILD %T_SRC_DIR%\SD_UP_ICON.png  %T_OUTPUT_DIR%\sd_up_icon.e
call:BUILD %T_SRC_DIR%\SD_UP_LIGHT_ICON.png  %T_OUTPUT_DIR%\sd_up_light_icon.e

:: call:BUILD %T_SRC_DIR%\SD_ICONS_10_10.png  ..\implementation\images\sd_icons_10_10.e
:: call:BUILD %T_SRC_DIR%\SD_ICONS_11_7.png  ..\implementation\images\sd_icons_11_7.e
:: call:BUILD %T_SRC_DIR%\SD_ICONS_16_16.png  ..\implementation\images\sd_icons_16_16.e
:: call:BUILD %T_SRC_DIR%\SD_ICONS_16_8.png  ..\implementation\images\sd_icons_16_8.e
:: call:BUILD %T_SRC_DIR%\SD_ICONS_32_32.png  ..\implementation\images\sd_icons_32_32.e
:: call:BUILD %T_SRC_DIR%\SD_ICONS_8_16.png  ..\implementation\images\sd_icons_8_16.e

endlocal
goto EOF

:: Function
:BUILD
echo Generate Eiffel code for %1 into %2
eiffel %EIFFEL_SRC%\tools\eiffel_image_embedder\eimgemb.ecf %*
goto:EOF
:EOF
