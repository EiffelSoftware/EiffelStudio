cd ..
svn up --depth empty                                          Src
svn up --depth empty                                          Src/Delivery
svn up                                                        Src/Delivery/studio
svn up                                                        Src/Delivery/VERSION
svn up --config-option config:miscellany:use-commit-times=yes Src/C_library 
svn up --config-option config:miscellany:use-commit-times=yes Src/C
svn up                                                        Src/Eiffel
svn up                                                        Src/dotnet
svn up --depth infinity                                       Src/contrib
svn up --depth infinity                                       Src/framework
svn up --depth infinity                                       Src/library
svn up --depth empty                                          Src/tools
svn up --depth infinity                                       Src/tools/compliance_checker
svn up --depth infinity                                       Src/unstable
svn up --depth empty                                          Src/web
svn up --depth empty                                          Src/web/support
svn up                                                        Src/web/support/client
svn up                                                        research
