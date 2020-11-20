# ALPINE RUBY, RBENV AND LIBV8
This is an Alpine 3.8 Ruby 1.9.3-p550 Docker image for the Ruby on Rails 4.1.8 proposal, including some build dependencies, bundler, and libv8 gems.

### BUILD
```
$ docker build -t alpine-ruby-rbenv-libv8 --rm=true .
```

### DEBUG / RUNNING
```
$ docker run -it alpine-ruby-rbenv-libv8
```

### DEBUG / RUNNING
```
$ docker run -p 8000:8000 alpine-ruby-rbenv-libv8 [optional -u user ...]
```

### LOGOUT
```
$ exit
```

&copy;bsilva0x87, 2020.