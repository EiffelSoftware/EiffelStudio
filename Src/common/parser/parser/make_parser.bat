%GOBO%\bin\geyacc --version
%GOBO%\bin\geyacc -x -t EIFFEL_TOKENS -o eiffel_parser.e eiffel.y
rem %GOBO%\bin\geyacc -x -v eiffel.out -t EIFFEL_TOKENS -o eiffel_parser.e eiffel.y
%GOBO%\bin\geyacc -x -t EXTERNAL_TOKENS -o external_parser.e external.y
rem %GOBO%\bin\geyacc -x -v eiffel.out -t EXTERNAL_TOKENS -o external_parser.e external.y
%GOBO%\bin\geyacc -x -t DUMMY -o cluster_indexing_parser.e cluster_indexing.y
