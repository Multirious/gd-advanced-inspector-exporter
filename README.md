Advanced Inspector Exporter
===========================
<p align="center">
  <a href="">
    <img src="/addons/advanced-inspector-exporter/adv_exp.svg" width="400" alt="Advance Inspector Exporter logo">
  </a>
</p>

This Godot Addon make variable advanced exporting in Godot easier.

> **Note:** This addon might be no use when Godot 4.0 come out with the new export keyword

<br>

What's advanced exporting you asked?
You can read the Godot documentation [here][advexpdoc]. Or see the preview below.

This is what you would normally see what inspector shows with normal export keyword

<p align="center">
  <img src="https://user-images.githubusercontent.com/77918086/167286441-f04f50dc-707c-4082-8897-a43256e79c68.png" width="400" alt="Advance Inspector Exporter logo">
</p>

Which is just fine but what if you wanted to organize something up?
Well, if you read the doc, you can do just that with the override function `_get_property_list()`

<p align="center">
  <img src="https://user-images.githubusercontent.com/77918086/167287121-dc539410-b767-4c0b-aa01-b6a974573e73.png" width="400" alt="Advance Inspector Exporter logo">
</p>

But doing that manually will be quite a pain and not very readable. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/77918086/167287261-2aae3662-3afe-4316-af49-f21aaa2f37f3.png" width="400" alt="Advance Inspector Exporter logo">
</p>

This addon will make that, looks like this.

<p align="center">
  <img src="https://user-images.githubusercontent.com/77918086/167287342-3802894a-6d99-46ee-9217-57e70006bfbe.png" width="400" alt="Advance Inspector Exporter logo">
</p>

More documentation about this plugin is inside the script file.


[advexpdoc]: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#advanced-exports "Godot Documentation for advance exporting"

## Installation
Just put `addons/advanced-inspector-exporter` in your addon folder
