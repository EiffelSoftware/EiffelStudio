#!/bin/bash

scss2css()
{
	sass --scss --sourcemap=none -t nested scss/$1.scss:css/$1.css
}

pushd site/themes/responsive-eiffel-org/assets
scss2css all

popd
