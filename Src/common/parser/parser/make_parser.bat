%EIFFEL_SRC%\library\gobo\bin\geyacc --version
%EIFFEL_SRC%\library\gobo\bin\geyacc -x -t EIFFEL_TOKENS -o eiffel_parser.e eiffel.y
rem %EIFFEL_SRC%\library\gobo\bin\geyacc -x -v eiffel.out -t EIFFEL_TOKENS -o eiffel_parser.e eiffel.y
%EIFFEL_SRC%\library\gobo\bin\geyacc -x -t EXTERNAL_TOKENS -o external_parser.e external.y
rem %EIFFEL_SRC%\library\gobo\bin\geyacc -x -v eiffel.out -t EXTERNAL_TOKENS -o external_parser.e external.y
%EIFFEL_SRC%\library\gobo\bin\geyacc -x -t DUMMY -o cluster_indexing_parser.e cluster_indexing.y
