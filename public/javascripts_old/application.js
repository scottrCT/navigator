// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
document.observe('form:button_disable', function (event) 
{
  // Find the button that we want to disable
  var button = $('nextFamLink');
  // Disable it!
  button.disabled = true;
  
  // Find the field that is required:
  var required_field = $('survey_age');
  
  // Set up an observer to monitor this field
  new Field.Observer(required_field, 0.3, function() {
    // If field == '' then button disabled = true
    button.disabled = ($F(required_field) === '');
    });
});