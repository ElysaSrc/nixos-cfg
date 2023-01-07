{ lib }:

{
  background = {
    medium = "#282828";
    hard = "#1d2021";
    soft = "#32302f";
    variant = "#504945";
  };

  white = "#ebdbb2";
  red = "#cc241d";
  green = "#98971a";
  yellow = "#d79921";
  blue = "#458588";
  purple = "#b16286";
  aqua = "#689d6a";
  orange = "#d65d0e";
  gray = "#928374";

  bright = {
    white = "#fbf1c7";
    red = "#fb4934";
    green = "#b8bb26";
    yellow = "#fabd2f";
    blue = "#83a598";
    purple = "#d3869b";
    aqua = "#8ec07c";
    orange = "#f38019";
    gray = "#a89984";
  };

  dim = {
    red = "#9d0006";
    green = "#79740e";
    yellow = "#b57614";
    blue = "#076678";
    purple = "#8f3f71";
    aqua = "#427b58";
    orange = "#d65d0e";
    white = "#928374";
  };

  nohex = s: lib.removePrefix "#" s;
}
