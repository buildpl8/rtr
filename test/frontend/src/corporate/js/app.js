/*
Template Name: Color Admin - Responsive Admin Dashboard Template build with Bootstrap 5
Version: 5.1.5
Author: Sean Ngu
Website: http://www.seantheme.com/color-admin/
	----------------------------
			APPS CONTENT TABLE
	----------------------------
	
	<!-- ======== GLOBAL SCRIPT SETTING ======== -->
	01. Handle Header Mobile Nav
	02. Handle Theme Panel Expand
	03. Handle Theme Page Control
  04. Handle Get Css Variable

	<!-- ======== APPLICATION SETTING ======== -->
	Application Controller
*/

var app = {
	font: {
	
	},
	color: {
	
	}
}


/* 01. Handle Header Mobile Nav
------------------------------------------------ */
var handleHeaderMobileNav = function() {
	$(document).on('click', '[data-toggle="header-mobile-nav"]', function(e) {
		e.preventDefault();
	
		$('.header .header-nav').slideToggle();
	});
};


/* 02. Handle Theme Panel Expand
------------------------------------------------ */
var handleThemePanelExpand = function() {
	$(document).on('click', '[data-click="theme-panel-expand"]', function() {
	var targetContainer = '.theme-panel';
	var targetClass = 'active';
	if ($(targetContainer).hasClass(targetClass)) {
		$(targetContainer).removeClass(targetClass);
	} else {
		$(targetContainer).addClass(targetClass);
	}
	});
};


/* 03. Handle Theme Page Control
------------------------------------------------ */
var handleThemePageControl = function() {
	if (typeof Cookies !== 'undefined') {
		$(document).on('click', '.theme-list [data-theme]', function(e) {	
			e.preventDefault();
			var targetThemeClass = $(this).attr('data-theme');
		
			for (var x = 0; x < document.body.classList.length; x++) {
				var targetClass = document.body.classList[x];
				if (targetClass.search('theme-') > -1) {
					$('body').removeClass(targetClass);
				}
			}
		
			$('body').addClass(targetThemeClass);
			$('.theme-list [data-theme]').not(this).closest('li').removeClass('active');
			$(this).closest('li').addClass('active');
		
			if (Cookies) {
				Cookies.set('theme', $(this).attr('data-theme'));
				$(document).trigger('theme-change');
			}
		});
		
		$(document).on('change', '.theme-panel [name="app-theme-dark-mode"]', function() {
			var targetCookie = '';
		
			if ($(this).is(':checked')) {
				$('html').addClass('dark-mode');
				targetCookie = 'dark-mode';
			} else {
				$('html').removeClass('dark-mode');
			}
		
			if (Cookies) {
				App.initVariable();
				Cookies.set('app-theme-dark-mode', targetCookie);
				$(document).trigger('theme-change');
			}
		});
		
		if (Cookies.get('theme') && $('.theme-list').length !== 0) {
			var targetElm = '.theme-list [data-theme="'+ Cookies.get('theme') +'"]';
			$(targetElm).trigger('click');
		}
		if (Cookies.get('app-theme-dark-mode') && $('.theme-panel [name="app-theme-dark-mode"]').length !== 0) {
			$('.theme-panel [name="app-theme-dark-mode"]').prop('checked', true).trigger('change');
		}
	}
};


/* 04. Handle Tooltip Activation
------------------------------------------------ */
var handleTooltipActivation = function() {
	if ($('[data-bs-toggle=tooltip]').length !== 0) {
		$('[data-bs-toggle=tooltip]').tooltip();
	}
};


/* 05. Handle Get Css Variable
------------------------------------------------ */
var getCssVariable = function(variable) {
	return window.getComputedStyle(document.body).getPropertyValue(variable).trim();
};


/* Application Controller
------------------------------------------------ */
var App = function () {
	"use strict";
	
	return {
		//main function
		init: function () {
			handleHeaderMobileNav();
			handleThemePanelExpand()
			handleThemePageControl();
			handleTooltipActivation();
			
			this.initVariable();
		},
		initVariable: function() {
			app.color.theme          = getCssVariable('--app-theme');
			app.font.family          = getCssVariable('--bs-body-font-family');
			app.font.size            = getCssVariable('--bs-body-font-size');
			app.font.weight          = getCssVariable('--bs-body-font-weight');
			app.color.componentColor = getCssVariable('--app-component-color');
			app.color.componentBg    = getCssVariable('--app-component-bg');
			app.color.dark           = getCssVariable('--bs-dark');
			app.color.light          = getCssVariable('--bs-light');
			app.color.blue           = getCssVariable('--bs-blue');
			app.color.indigo         = getCssVariable('--bs-indigo');
			app.color.purple         = getCssVariable('--bs-purple');
			app.color.pink           = getCssVariable('--bs-pink');
			app.color.red            = getCssVariable('--bs-red');
			app.color.orange         = getCssVariable('--bs-orange');
			app.color.yellow         = getCssVariable('--bs-yellow');
			app.color.green          = getCssVariable('--bs-green');
			app.color.success        = getCssVariable('--bs-success');
			app.color.teal           = getCssVariable('--bs-teal');
			app.color.cyan           = getCssVariable('--bs-cyan');
			app.color.white          = getCssVariable('--bs-white');
			app.color.gray           = getCssVariable('--bs-gray');
			app.color.lime           = getCssVariable('--bs-lime');
			app.color.gray100        = getCssVariable('--bs-gray-100');
			app.color.gray200        = getCssVariable('--bs-gray-200');
			app.color.gray300        = getCssVariable('--bs-gray-300');
			app.color.gray400        = getCssVariable('--bs-gray-400');
			app.color.gray500        = getCssVariable('--bs-gray-500');
			app.color.gray600        = getCssVariable('--bs-gray-600');
			app.color.gray700        = getCssVariable('--bs-gray-700');
			app.color.gray800        = getCssVariable('--bs-gray-800');
			app.color.gray900        = getCssVariable('--bs-gray-900');
			app.color.black          = getCssVariable('--bs-black');
			
			app.color.themeRgb          = getCssVariable('--app-theme-rgb');
			app.font.familyRgb          = getCssVariable('--bs-body-font-family-rgb');
			app.font.sizeRgb            = getCssVariable('--bs-body-font-size-rgb');
			app.font.weightRgb          = getCssVariable('--bs-body-font-weight-rgb');
			app.color.componentColorRgb = getCssVariable('--app-component-color-rgb');
			app.color.componentBgRgb    = getCssVariable('--app-component-bg-rgb');
			app.color.darkRgb           = getCssVariable('--bs-dark-rgb');
			app.color.lightRgb          = getCssVariable('--bs-light-rgb');
			app.color.blueRgb           = getCssVariable('--bs-blue-rgb');
			app.color.indigoRgb         = getCssVariable('--bs-indigo-rgb');
			app.color.purpleRgb         = getCssVariable('--bs-purple-rgb');
			app.color.pinkRgb           = getCssVariable('--bs-pink-rgb');
			app.color.redRgb            = getCssVariable('--bs-red-rgb');
			app.color.orangeRgb         = getCssVariable('--bs-orange-rgb');
			app.color.yellowRgb         = getCssVariable('--bs-yellow-rgb');
			app.color.greenRgb          = getCssVariable('--bs-green-rgb');
			app.color.successRgb        = getCssVariable('--bs-success-rgb');
			app.color.tealRgb           = getCssVariable('--bs-teal-rgb');
			app.color.cyanRgb           = getCssVariable('--bs-cyan-rgb');
			app.color.whiteRgb          = getCssVariable('--bs-white-rgb');
			app.color.grayRgb           = getCssVariable('--bs-gray-rgb');
			app.color.limeRgb           = getCssVariable('--bs-lime-rgb');
			app.color.gray100Rgb        = getCssVariable('--bs-gray-100-rgb');
			app.color.gray200Rgb        = getCssVariable('--bs-gray-200-rgb');
			app.color.gray300Rgb        = getCssVariable('--bs-gray-300-rgb');
			app.color.gray400Rgb        = getCssVariable('--bs-gray-400-rgb');
			app.color.gray500Rgb        = getCssVariable('--bs-gray-500-rgb');
			app.color.gray600Rgb        = getCssVariable('--bs-gray-600-rgb');
			app.color.gray700Rgb        = getCssVariable('--bs-gray-700-rgb');
			app.color.gray800Rgb        = getCssVariable('--bs-gray-800-rgb');
			app.color.gray900Rgb        = getCssVariable('--bs-gray-900-rgb');
			app.color.blackRgb          = getCssVariable('--bs-black-rgb');
		}
  };
}();

$(document).ready(function() {
	App.init();
});