# dotfiles

Created using the technique described here: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ which definitely has at least one [archive](https://web.archive.org/web/20170326125752/https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) on the Wayback Machine.

The only change I made to that technique was the addition of this readme. I wanted to be able to come back to that article explaining the somewhat non-trivial order of steps in restoring these dotfiles, so I wanted to add a readme. However, I don't want a big ol' `README.md` in my home directory. So, I added this, committed, and then removed it. Then I ran: `config update-index --assume-unchanged README.md`. This got git off my case about having deleted it.

So, if you clone it, after having followed the directions seen on the website, to get rid of the `README.md`, all you must do is:

    $ rm README.md
    $ config update-index --assume-unchanged README.md
