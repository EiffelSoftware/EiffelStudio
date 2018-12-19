Docker container for EiffelWeb debug example with apache2+libfcgi.
==================================================================

This example demonstrates the use of EiffelWeb with Apache2, using the libfcgi connector.
For that, it is using the Docker solution to show the compilation and configuration steps.

To build the docker image:

```
	docker build -t local/ewf-debug-httpd .
```

To run the docker image in a self-destroyed container:
```
	docker run --rm -dit -p 8080:80 --name my-ewf-debug local/ewf-debug-httpd
```

Notes:
	- `--rm` : to remove the container after the execution
	- `-p 8080:80` : to map internal listening port 80 to localhost port 8080.
	- on Linux, you may need to use `sudo` to be able to use `docker`
	- depending on the docker installation, you may need to add an extra `-e ISE_PLATFORM=linux-x86` to force execution in 32bits.
	- This docker example is simple on purpose. For production it should be improved and optimized to keep the image smaller and more customizable.
	- For more advanced Docker usage, please refer to official https://www.docker.com/ website.

