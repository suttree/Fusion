// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function cursorAnimation() {
  $("span.cursor").animate(
  {
    opacity: 0
  }, "fast", "swing").animate(
  {
    opacity: 1
  }, "fast", "swing");
}