var floatingButtonMenu = (function () {
    "use strict";
    var scriptVersion = "1.0";
    var util = {
        version: "1.2.5",
        isDefinedAndNotNull: function (pInput) {
            if (typeof pInput !== "undefined" && pInput !== null) {
                return true;
            } else {
                return false;
            }
        },
        isAPEX: function () {
            if (typeof (apex) !== 'undefined') {
                return true;
            } else {
                return false;
            }
        },
        debug: {
            info: function (str) {
                if (util.isAPEX()) {
                    apex.debug.info(str);
                }
            },
            error: function (str) {
                if (util.isAPEX()) {
                    apex.debug.error(str);
                } else {
                    console.error(str);
                }
            }
        },
        jsonSaveExtend: function (srcConfig, targetConfig) {
            var finalConfig = {};
            var tmpJSON = {};
            /* try to parse config json when string or just set */
            if (typeof targetConfig === 'string') {
                try {
                    tmpJSON = JSON.parse(targetConfig);
                } catch (e) {
                    console.error("Error while try to parse targetConfig. Please check your Config JSON. Standard Config will be used.");
                    console.error(e);
                    console.error(targetConfig);
                }
            } else {
                tmpJSON = targetConfig;
            }
            /* try to merge with standard if any attribute is missing */
            try {
                finalConfig = $.extend(true, srcConfig, tmpJSON);
            } catch (e) {
                console.error('Error while try to merge 2 JSONs into standard JSON if any attribute is missing. Please check your Config JSON. Standard Config will be used.');
                console.error(e);
                finalConfig = srcConfig;
                console.error(finalConfig);
            }
            return finalConfig;
        },
        link: function (link, tabbed) {
            if (tabbed) {
                window.open(link, "_blank");
            } else {
                return window.location = link;
            }
        },
        isTouchDevice: function () {
            return "ontouchstart" in window;
        }
    };

    return {

        initialize: function (elementID, ajaxID, setConfigJSON, items2Submit, escapeRequired, syncData) {

            var el = elementID || "afbm";
            var elSel = "#" + el;
            var stdConfigJSON = {
                "refresh": 0,
                "btnIcon": "fa-plus",
                "btnIconHover": "fa-close",
                "btnColor": "#F44336",
                "btnRippleColor": "#F44336",
                "btnIconColor": "white",
                "btnPositionBottom": "45px",
                "btnPositionRight": "45px",
                "linkTargetBlank": true,
                "rippleEffect": true
            };

            if (setConfigJSON) {
                var configJSON = util.jsonSaveExtend(stdConfigJSON, setConfigJSON);
            } else {
                var configJSON = stdConfigJSON;
            }

            if (syncData) {
                drawBody(syncData);
            } else {
                /***********************************************************************
                 **
                 ** function to get data from Apex
                 **
                 ***********************************************************************/
                function getData(f) {
                    apex.server.plugin(
                        ajaxID, {
                            pageItems: items2Submit
                        }, {
                            success: function (d) {
                                f(d);
                            },
                            error: function (d) {
                                util.debug.error("Error while try to load data!");
                                util.debug.error(d.responseText);
                            },
                            dataType: "json"
                        });
                }


                /* get data and draw */
                getData(drawBody);

                /* Used to set a refresh via json configuration */
                if (configJSON.refresh > 0) {
                    var refreshInterval;
                    refreshInterval = setInterval(function () {
                        if ($(elSel).length === 0) {
                            clearInterval(refreshInterval);
                        } else {
                            util.debug.info("Refresh event was fired");
                            getData(drawBody);
                        }
                    }, configJSON.refresh * 1000);
                }
            }

            /***********************************************************************
             **
             ** Used to draw a note body
             **
             ***********************************************************************/
            function drawBody(dataJSON) {

                if (dataJSON && dataJSON.row && dataJSON.row.length > 0) {
                    var oldDiv = $(elSel);
                    var searchString = "fa-";

                    util.debug.info(dataJSON);
                    var items = dataJSON.row;
                    util.debug.info(items);
                    var btnItems = dataJSON.row[0];
                    util.debug.info(btnItems);

                    var div = $("<div></div>");
                    div.addClass("afbm-float");
                    div.attr("id", el);
                    div.css("bottom", btnItems.BTN_POSITION_BOTTOM || configJSON.btnPositionBottom);
                    div.css("right", btnItems.BTN_POSITION_RIGHT || configJSON.btnPositionRight);

                    var ul = $("<ul></ul>");
                    ul.addClass("afbm-float-list");

                    $.each(items, function (idx, item) {
                        var li = $("<li></li>");
                        li.addClass("afbm-float-list-item");

                        var span = $("<span></span>");
                        span.addClass("afbm-float-list-item-label");
                        if (escapeRequired !== false) {
                            span.text(item.ITEM_TEXT);
                        } else {
                            span.html(item.ITEM_TEXT);
                        }
                        if (item.ITEM_TEXT_COLOR) {
                            span.css("color", item.ITEM_TEXT_COLOR);
                        }
                        if (item.ITEM_TEXT_BACKGROUND) {
                            span.css("background", item.ITEM_TEXT_BACKGROUND);
                        }

                        li.append(span);

                        if (item.ITEM_LINK) {
                            li.on("click", function (e) {
                                util.link(item.ITEM_LINK, configJSON.linkTargetBlank);
                                e.stopPropagation();
                            });
                        }

                        var icon = $("<span></span>");
                        icon.addClass("afbm-float-list-item-icon");
                        icon.addClass("afbm-center-abs");
                        var bgColor = 'linear-gradient(60deg, hsl(' + (idx * 23) % 350 + ', 79%, 45%), hsl(' + (idx * 23) % 350 + ', 60%, 45%))';
                        icon.css("background-color", item.ITEM_COLOR || bgColor);

                        if (util.isDefinedAndNotNull(item.ITEM_ICON)) {
                            var iconSpan = $("<span></span>");
                            if (item.ITEM_ICON.substr(0, searchString.length) === searchString) {
                                iconSpan.addClass("fa " + item.ITEM_ICON);
                                if (util.isDefinedAndNotNull(item.ITEM_ICON_COLOR)) {
                                    icon.css("color", item.ITEM_ICON_COLOR);
                                }
                            } else {
                                icon.css("background-image", "url(" + item.ITEM_ICON + ")");
                            }

                            icon.append(iconSpan);
                        }

                        li.append(icon);

                        ul.append(li);
                    });

                    div.append(ul);

                    var btn = $("<div></div>");
                    btn.addClass("afbm-float-btn");
                    btn.css("background", btnItems.BTN_COLOR || configJSON.btnColor);

                    if (configJSON.rippleEffect) {
                        var btnBefore = $("<div></div>");
                        btnBefore.addClass("afbm-float-btn-before");
                        btn.prepend(btnBefore);
                        btnBefore.css("border-color", btnItems.BTN_RIPPLE_COLOR || configJSON.btnRippleColor);
                    }

                    var btnDiv1 = $("<div></div>");
                    btnDiv1.addClass("afbm-float-btn-icon");
                    btnDiv1.addClass("afbm-float-btn-icon-closed");
                    btnDiv1.addClass("afbm-center-abs");

                    var btnDiv1Icon = $("<span></span>");
                    btnDiv1Icon.addClass("fa");
                    btnDiv1Icon.addClass(btnItems.BTN_ICON || configJSON.btnIcon);
                    btnDiv1Icon.addClass("fa-lg");
                    btnDiv1Icon.css("color", btnItems.BTN_ICON_COLOR || configJSON.btnIconColor);
                    btnDiv1.append(btnDiv1Icon);

                    btn.append(btnDiv1);

                    var btnDiv2 = $("<div></div>");
                    btnDiv2.addClass("afbm-float-btn-icon");
                    btnDiv2.addClass("afbm-float-btn-icon-opened");

                    var btnDiv2Icon = $("<span></span>");
                    btnDiv2Icon.addClass("fa");
                    btnDiv2Icon.addClass(btnItems.BTN_ICON_HOVER || configJSON.btnIconHover);
                    btnDiv2Icon.addClass("fa-lg");
                    btnDiv2Icon.css("color", btnItems.BTN_ICON_COLOR || configJSON.btnIconColor);

                    btnDiv2.append(btnDiv2Icon);

                    btn.append(btnDiv2);

                    div.append(btn);

                    div.on("click", function (e) {
                        if (btnBefore) {
                            btnBefore.toggle();
                        }
                        div.toggleClass("is-active");
                        e.stopPropagation();
                    });

                    if (!util.isTouchDevice()) {
                        div.on("mouseover", function (e) {
                            if (btnBefore) {
                                btnBefore.hide();
                            }
                            div.addClass("is-active");
                            e.stopPropagation();
                        });

                        div.on("mouseout", function (e) {
                            if (btnBefore) {
                                btnBefore.show();
                            }
                            div.removeClass("is-active");
                            e.stopPropagation();
                        });
                    } else {
                        $(document).on("touchstart click", function (e) {
                            if (!div.is(e.target) && div.has(e.target).length === 0) {
                                if (btnBefore) {
                                    btnBefore.show();
                                }
                                div.removeClass("is-active");
                            }
                            e.stopPropagation();
                        });
                    }

                    $("body").append(div);
                    oldDiv.fadeOut(1000, function () {
                        $.each(oldDiv, function (i, oldItem) {
                            oldItem.remove();
                        });
                    });
                    div.fadeIn(1000);
                }
            }
        }
    }
})();
