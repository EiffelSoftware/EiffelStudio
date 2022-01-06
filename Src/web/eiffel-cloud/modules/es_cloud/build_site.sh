#!/bin/bash

scss2css()
{
	sass --scss --sourcemap=none -t expanded scss/$1.scss:css/$1.css
}

pushd site/files
#sass --scss --sourcemap=none -t expanded scss/es_cloud-admin.scss:css/es_cloud-admin.css
scss2css es_cloud
scss2css es_cloud-admin
scss2css es_forms
scss2css pricing

popd
