COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\eiffel_parser_skeleton.e"
sed -e "s/\<TYPE\>/EIFFEL_TYPE/g" eiffel_parser_skeleton.e > new.e
del eiffel_parser_skeleton.e
ren new.e eiffel_parser_skeleton.e

COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\eiffel.l"
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\eiffel.y"
sed -e "s/\<TYPE\>/EIFFEL_TYPE/g" eiffel.y > new.y
del eiffel.y
ren new.y eiffel.y
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\external.l"
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\external.y"
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\cluster_indexing.y"
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\shared_parser_file_buffer.e"
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\token_location.e"
COPY "%EIFFEL_SRC%\Eiffel\common\parser\parser\makefile"

call nmake

del *.y
del *.l
del makefile
