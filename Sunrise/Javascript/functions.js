
// Scroll Decrease
var menu_item = document.getElementsByClassName('navbar__item--controls')[0];
menu_item.getElementsByClassName('js-navbar-controls-prev')[0].click();

// Scroll Increase
var menu_item = document.getElementsByClassName('navbar__item--controls')[0];
menu_item.getElementsByClassName('js-navbar-controls-next')[0].click();

// Scroll to Today
var menu_item = document.getElementsByClassName('navbar__item--today')[0];
menu_item.firstChild.click();

// Invite Popover
var menu_item = document.getElementsByClassName('invitations-logo')[0];
menu_item.firstChild.click();

// Display Month
var menu_item = document.getElementsByClassName('navbar__item--location')[0];
menu_item.getElementsByClassName('navbar__item--location__month')[0].click();

// Display Week
var menu_item = document.getElementsByClassName('navbar__item--location')[0];
menu_item.getElementsByClassName('navbar__item--location__week')[0].click();
