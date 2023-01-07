{ lib }:

let
  c = import ../../../lib/colors.nix { lib = lib; };
in ''
  window {
    background-color: ${c.background.medium};
    border-color: ${c.green};
    border-width: 2px;
    border-style: solid;
    border-radius: 5px;
  }

  #input {
    margin: 0px;
    padding: 0px;
    border-radius: 0px;
    padding-left: 6px;
    padding-right: 4px;
    border: solid 1px rgba(55, 71, 79, 1);
    background-color: ${c.background.hard};
    font: 13px "JetBrains Mono";
    color: ${c.white};
    font-weight: 400;
    border: none;
  }

  #input:focus, #input:active {
    border: none;
  }

  #filter {
    background-color: red;
  }

  #inner-box {
    margin: 0px;
    background-color: ${c.background.medium};
    border: none;
  }

  #outer-box {
    margin: 2px;
    border: none;
    background-color: ${c.background.medium};
  }

  #entry {
    background-color: transparent;
    border-radius: 0;
  }

  #entry:selected {
    background-color: ${c.green};
    border: none;
    border-radius: 0;
    outline: none;
  }

  #text {
    padding: 0px;
    color: ${c.white};
    font: 13px "JetBrains Mono";
    margin-left: 8px;
  }

  #text:selected {
    color: ${c.white};
  }
''
