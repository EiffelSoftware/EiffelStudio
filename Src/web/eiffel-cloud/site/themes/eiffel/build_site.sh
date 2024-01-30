#!/bin/bash

scss2css()
{
	sass --scss --sourcemap=none -t expanded scss/$1.scss:css/$1.css
}

echo [themes/eiffel] Build css files from scss 

pushd assets
#sass --scss --sourcemap=none -t expanded scss/es_cloud-admin.scss:css/es_cloud-admin.css
scss2css style

popd
