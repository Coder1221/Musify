// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

require("jquery");
require("@nathanvda/cocoon");

Rails.start();
Turbolinks.start();
ActiveStorage.start();

var setPhoneNumber = function (area, pre, tel) {
  var output = "";
  if (area.length < 3) {
    output = "+1 (" + area;
  } else if (area.length == 3 && pre.length < 3) {
    output = "+1 (" + area + ")" + " " + pre;
  } else if (area.length == 3 && pre.length == 3) {
    output = "+1 (" + area + ")" + " " + pre + "-" + tel;
  }
  return output;
};
$(document).ready(function () {
  $("input[type='tel']").each(function () {
    $(this).attr({
      maxlength: "17",
      pattern: "\\+1 \\(\\d{3}\\)[ ]?\\d{3}[-]?\\d{4}",
      title: "format: +1 (123) 456-7890",
    });
    $(this).bind("keyup", function (e) {
      var $this = $(this);
      var input = $this.val();
      if (e.keyCode != 8) {
        input = input.replace(/[^0-9]/g, "");
        if (input.length == 1) {
          var area = input.substr(0, 3);
        } else {
          var area = input.substr(1, 3);
        }
        var pre = input.substr(4, 3);
        var tel = input.substr(7, 4);
        $this.val(setPhoneNumber(area, pre, tel));
      }
    });
  });
});
$(document).ready(function () {
  $("input[type='tel']").each(function () {
    $(this).bind("paste ", function (e) {
      var input = e.originalEvent.clipboardData.getData("text");
      input = input.replace(/[^0-9]/g, "");
      if (input.length == 11) {
        input = input.substr(1, 10);
      }
      var area = input.substr(0, 3);
      var pre = input.substr(3, 3);
      var tel = input.substr(6, 4);
      $(this).val(setPhoneNumber(area, pre, tel));
      e.preventDefault();
    });
  });
});
