# My Development Environment

A base image to be used as starting point for other images or good for standalone use.

Based on alpine (my uWSGI image also my python 3 build) and currently using a few Java bits.

## Using

All activities are wrapped in a makefile.

| Target      | Description                       |
+-------------+-----------------------------------+
| run         | Run the image (shell prompt)      |
| build       | Builds the image                  |
| kill        | Kills the currently running image |
| pull        | Updates images                    |
| all         | Build and run it                  |

Simply running ```make all``` will give a running prompt.
