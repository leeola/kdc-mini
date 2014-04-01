
# KDC Mini

KDC Mini is a simple build tool for [Koding][0] Apps.

## Why

Koding itself calls the command `kdc ~/Applications/<appName>` to build your
app. This runs the `kdc` binary, which just runs your code through the coffee
compiler and spits it into a single javascript file.

This process is a very common practice and many build tools have this
feature set. Furthermore, other build tools may be preferred by the programmer,
since they offer additional features and are often pluggable. With kdc-mini, you
can use whatever build tool you like. Koding only cares about the final
index.js file, and whatever resources you have defined in your manifest.

## Usage

Simply define a root level "build" key in your manifest file, with whatever
command you want to run. Below is an example manifest with a gulp file defined.

```json
{
  "name": "HelloWorld",
  "path": "~/Applications/hello.kdapp",
  "source": {
    "blocks": {
      "app": {
        "files": [
          "./index.coffee"
        ]
      }
    }
  },
  "build": "gulp build"
}
```

## Notes

kdc-mini does not pass in any information from the manifest. Since the goal here
is to support *any* build tool you might want, whether it's Grunt, Gulp, or even
Make, all `kdc-mini` can do is call your binary with whatever arguments you
defined.

In the future i may add some variables from the manifest, such as a files list
or resource list, but for now we're keeping it very very light.


[0]: https://koding.com
