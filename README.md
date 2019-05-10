# My Development Environment

A base image to be used as starting point for other images or good for standalone use.

Based on Alpine Linux (with my custom uWSGI & Python 3 builds on top see [mkit](https://github.com/dellelce/mkit) and currently using a few Java bits.

## Using

All activities are wrapped in a makefile.

| Target      | Description                       |
|-------------|-----------------------------------|
| run         | Run the image (shell prompt)      |
| build       | Builds the image                  |
| kill        | Kills the currently running image |
| pull        | Updates base images               |
| all         | Build and run image               |

Simply running ```make all``` will give a running prompt.
