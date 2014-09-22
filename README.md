# Fooprint
![](https://dl.dropboxusercontent.com/u/663533/fooprint/issue.png)

If you are in possession of a printer that does not support a duplex printing mode, the only option to print two pages per sheet is to manually print first all the even and then all the odd pages. Especially when you want to print several pages per site of a shee of paper you may end up in trouble when computing all the indices by yourself - at least I noticed this for myself :D

**Fooprint** is a Ruby script that generates you the even and odd page printing range for your non-duplex printer. Then, you simply can put these statements into the red marked box from above's figure. You can pass a from- and a to-page of the document which should be printed. Furthermore you have to pass a 3rd argument which determines the number of pages per site.

The new workflowWorkflow:
1. Compute your ranges indices using this scripts.
2. start the 1st printing job using the even indices.
3. put printed paper back into your printer's paper tray (printed page downward).
4. start the 2nd printing job using the odd indices.

Fooprint is licensed under the [MIT License](http://opensource.org/licenses/MIT).

## Installation
Assuming you have successfully installed **ruby**, **rvm** and **ruby-gems** you only have to clone this repository, browse into its root directory and then simply run ````bundle````.

## Usage
In order to run this application, type ````ruby fooprint.rb -l 1 -u 28 -s 2```` into your console prompt - while being in the application's root directory.
This example will print the printing instruction for printing two pages per sheet from starting from page 1 to page 28.

## Contributing
1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)
