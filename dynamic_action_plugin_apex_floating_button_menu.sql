prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.3.00.05'
,p_default_workspace_id=>21717127411908241868
,p_default_application_id=>103428
,p_default_owner=>'RD_DEV'
);
end;
/
 
prompt APPLICATION 103428 - Plug-in Samples
--
-- Application Export:
--   Application:     103428
--   Name:            Plug-in Samples
--   Date and Time:   22:39 Monday February 24, 2020
--   Exported By:     RONNYWEISS@OUTLOOK.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 55333151726598902381
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/apex_floating_button_menu
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(55333151726598902381)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'APEX.FLOATING.BUTTON.MENU'
,p_display_name=>'APEX Floating Button Menu'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION F_AJAX (',
'    P_DYNAMIC_ACTION   IN APEX_PLUGIN.T_DYNAMIC_ACTION,',
'    P_PLUGIN           IN APEX_PLUGIN.T_PLUGIN',
') RETURN APEX_PLUGIN.T_DYNAMIC_ACTION_AJAX_RESULT IS',
'    VR_RESULT         APEX_PLUGIN.T_DYNAMIC_ACTION_AJAX_RESULT;',
'BEGIN',
'    APEX_UTIL.JSON_FROM_SQL( SQLQ   => P_DYNAMIC_ACTION.ATTRIBUTE_04 );',
'    RETURN VR_RESULT;',
'END;',
'',
'FUNCTION F_RENDER (',
'    P_DYNAMIC_ACTION   IN APEX_PLUGIN.T_DYNAMIC_ACTION,',
'    P_PLUGIN           IN APEX_PLUGIN.T_PLUGIN',
') RETURN APEX_PLUGIN.T_DYNAMIC_ACTION_RENDER_RESULT AS',
'    VR_RESULT         APEX_PLUGIN.T_DYNAMIC_ACTION_RENDER_RESULT;',
'    VR_REQUIRE_ESCAPE BOOLEAN := TRUE;',
'BEGIN',
'    APEX_CSS.ADD_FILE(',
'        P_NAME        => ''afbm.pkgd.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''afbmcsssrc''',
'    );',
'',
'   APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME        => ''afbm.pkgd.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''afbmjssrc''',
'    );',
'',
'    IF',
'        P_DYNAMIC_ACTION.ATTRIBUTE_05 = ''N''',
'    THEN',
'        VR_REQUIRE_ESCAPE   := FALSE;',
'    ELSE',
'        VR_REQUIRE_ESCAPE   := TRUE;',
'    END IF;',
'    ',
'',
'    VR_RESULT.JAVASCRIPT_FUNCTION   := ''function () {',
'  floatingButtonMenu.initialize('' ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_02, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN.GET_AJAX_IDENTIFIER, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_01, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(P_DYNAMIC_ACTION.ATTRIBUTE_03), TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( VR_REQUIRE_ESCAPE, FALSE ) ||',
'    '');}'';',
'',
'    RETURN VR_RESULT;',
'END;'))
,p_api_version=>1
,p_render_function=>'F_RENDER'
,p_ajax_function=>'F_AJAX'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This plugin is used to add a floating button menu to the page.',
'',
'To Trigger a manual refresh just create a dynmic action e.g. on button click with the action "Refresh" and set as "Affected Element" a jQuery Selector. Then enter the ID that was set as Element ID for Notification Menu.'))
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/RonnyWeiss/APEX-floating-Button-Menu'
,p_files_version=>1447
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(27794549877320335211)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'ConfigJSON'
,p_attribute_type=>'JAVASCRIPT'
,p_is_required=>true
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{',
'  "refresh": 0,',
'  "btnColor": "#F44336",',
'  "btnIcon": "fa-plus",',
'  "btnIconColor": "white",',
'  "btnIconHover": "fa-close",',
'  "btnPositionBottom": "45px",',
'  "btnPositionRight": "45px",',
'  "btnRippleColor": "#F44336",',
'  "linkTargetBlank": true,',
'  "rippleEffect": true',
'}'))
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'{',
'  "refresh": 0,',
'  "btnColor": "#F44336",',
'  "btnIcon": "fa-plus",',
'  "btnIconColor": "white",',
'  "btnIconHover": "fa-close",',
'  "btnPositionBottom": "45px",',
'  "btnPositionRight": "45px",',
'  "btnRippleColor": "#F44336",',
'  "linkTargetBlank": true,',
'  "rippleEffect": true',
'}',
'</pre>',
'<h3>Explanation:</h3>',
'<ul>',
'<li><b>refresh (number):</b> refresh the item in seconds (if set to 0 refresh is stopped)</li>',
'<li><b>btnColor (string):</b> color of the float button</li>',
'<li><b>btnIcon (string):</b> icon of the float button when closed</li>',
'<li><b>btnIconColor (string):</b> color of the float button icon</li>',
'<li><b>btnIconHover (string):</b> icon of the float button when opened</li>',
'<li><b>btnPositionBottom (string):</b> position from bottom of body</li>',
'<li><b>btnPositionRight (string):</b> position from right of body</li>',
'<li><b>btnRippleColor (string):</b> color of the float button ripple</li>',
'<li><b>linkTargetBlank (boolean):</b> open links in new tab</li>',
'<li><b>rippleEffect (boolean):</b> show ripple effect</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(55333152338340902385)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>3
,p_prompt=>'Element ID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'floating-menu'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(55333152681178902385)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>2
,p_prompt=>'Items to Submit'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(55333153088669902386)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>1
,p_prompt=>'SQL Source'
,p_attribute_type=>'SQL'
,p_is_required=>true
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    /* icon of the float button when closed - only first row is used */',
'    ''fa-users-chat'' AS BTN_ICON,',
'    /* color of the float button - only first row is used */',
'    ''linear-gradient(60deg, hsl('' || ROUND(MOD((TRUNC(SYSDATE) - SYSDATE) * 1000000,350)) ||'', 79%, 45%), hsl('' || ROUND(MOD((TRUNC(SYSDATE) - SYSDATE) * 1000000,350))||'', 60%, 45%))'' AS BTN_COLOR,',
'    /* color of the float button ripple - only first row is used */',
'    ''hsl('' || ROUND(MOD((TRUNC(SYSDATE) - SYSDATE) * 1000000,350)) ||'', 79%, 45%)'' AS BTN_RIPPLE_COLOR,',
'    /* color of the float button icon - only first row is used */',
'    ''white'' AS BTN_ICON_COLOR,',
'    /* icon of the float button when opened - only first row is used */',
'    ''fa-close'' AS BTN_ICON_HOVER,',
'    /* position from bottom of body - only first row is used */',
'    ''30px'' AS BTN_POSITION_BOTTOM,',
'    /* position from right of body - only first row is used */',
'    ''30px'' AS BTN_POSITION_RIGHT,',
'    /* icon of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''fa-tree''',
'      WHEN 2 THEN ''fa-twitter''',
'      WHEN 3 THEN ''fa-github''',
'      WHEN 4 THEN ''https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/132px-Instagram_logo_2016.svg.png''',
'      WHEN 5 THEN ''fa-linkedin''',
'      ELSE NULL',
'    END AS ITEM_ICON,',
'    /* text of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''Linktree''',
'      WHEN 2 THEN ''Twitter''',
'      WHEN 3 THEN ''gitHub''',
'      WHEN 4 THEN ''Instagram''',
'      WHEN 5 THEN ''LinkedIn''',
'      ELSE NULL',
'    END AS ITEM_TEXT,',
'    /* text color of the item in list */',
'    ''white'' AS ITEM_TEXT_COLOR,',
'    /* text background color of the item in list */',
'    ''#303030'' AS ITEM_TEXT_BACKGROUND,',
'    /* link of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''https://linktr.ee/ronny.weiss''',
'      WHEN 2 THEN ''https://twitter.com/ronny_weiss_'' ',
'      WHEN 3 THEN ''https://github.com/RonnyWeiss''',
'      WHEN 4 THEN ''https://www.instagram.com/ronnyweiss_/''',
'      WHEN 5 THEN ''https://www.linkedin.com/in/ronny-wei%C3%9F-12b503185/''',
'      ELSE NULL',
'    END AS ITEM_LINK,',
'    /* open link as in new tab */',
'    1 AS ITEM_LINK_BANK,',
'    /* color of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''#00dc9e''',
'      WHEN 2 THEN ''#1DA1F2''',
'      WHEN 3 THEN ''black''',
'      WHEN 4 THEN ''white''',
'      WHEN 5 THEN ''#2867b2''',
'      ELSE NULL',
'    END AS ITEM_COLOR,',
'    /* icon color of the item in list */',
'    CASE ROWNUM',
'      WHEN 4 THEN ''black''',
'      ELSE ''white''',
'    END AS ITEM_ICON_COLOR',
'FROM',
'    DUAL CONNECT BY ROWNUM <= 5'))
,p_sql_min_column_count=>1
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'SELECT',
'    /* icon of the float button when closed - only first row is used */',
'    ''fa-users-chat'' AS BTN_ICON,',
'    /* color of the float button - only first row is used */',
'    ''linear-gradient(60deg, hsl('' || ROUND(MOD((TRUNC(SYSDATE) - SYSDATE) * 1000000,350)) ||'', 79%, 45%), hsl('' || ROUND(MOD((TRUNC(SYSDATE) - SYSDATE) * 1000000,350))||'', 60%, 45%))'' AS BTN_COLOR,',
'    /* color of the float button ripple - only first row is used */',
'    ''hsl('' || ROUND(MOD((TRUNC(SYSDATE) - SYSDATE) * 1000000,350)) ||'', 79%, 45%)'' AS BTN_RIPPLE_COLOR,',
'    /* color of the float button icon - only first row is used */',
'    ''white'' AS BTN_ICON_COLOR,',
'    /* icon of the float button when opened - only first row is used */',
'    ''fa-close'' AS BTN_ICON_HOVER,',
'    /* position from bottom of body - only first row is used */',
'    ''30px'' AS BTN_POSITION_BOTTOM,',
'    /* position from right of body - only first row is used */',
'    ''30px'' AS BTN_POSITION_RIGHT,',
'    /* icon of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''fa-tree''',
'      WHEN 2 THEN ''fa-twitter''',
'      WHEN 3 THEN ''fa-github''',
'      WHEN 4 THEN ''https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/132px-Instagram_logo_2016.svg.png''',
'      WHEN 5 THEN ''fa-linkedin''',
'      ELSE NULL',
'    END AS ITEM_ICON,',
'    /* text of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''Linktree''',
'      WHEN 2 THEN ''Twitter''',
'      WHEN 3 THEN ''gitHub''',
'      WHEN 4 THEN ''Instagram''',
'      WHEN 5 THEN ''LinkedIn''',
'      ELSE NULL',
'    END AS ITEM_TEXT,',
'    /* text color of the item in list */',
'    ''white'' AS ITEM_TEXT_COLOR,',
'    /* text background color of the item in list */',
'    ''#303030'' AS ITEM_TEXT_BACKGROUND,',
'    /* link of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''https://linktr.ee/ronny.weiss''',
'      WHEN 2 THEN ''https://twitter.com/ronny_weiss_'' ',
'      WHEN 3 THEN ''https://github.com/RonnyWeiss''',
'      WHEN 4 THEN ''https://www.instagram.com/ronnyweiss_/''',
'      WHEN 5 THEN ''https://www.linkedin.com/in/ronny-wei%C3%9F-12b503185/''',
'      ELSE NULL',
'    END AS ITEM_LINK,',
'    /* open link as in new tab */',
'    1 AS ITEM_LINK_BANK,',
'    /* color of the item in list */',
'    CASE ROWNUM',
'      WHEN 1 THEN ''#00dc9e''',
'      WHEN 2 THEN ''#1DA1F2''',
'      WHEN 3 THEN ''black''',
'      WHEN 4 THEN ''white''',
'      WHEN 5 THEN ''#2867b2''',
'      ELSE NULL',
'    END AS ITEM_COLOR,',
'    /* icon color of the item in list */',
'    CASE ROWNUM',
'      WHEN 4 THEN ''black''',
'      ELSE ''white''',
'    END AS ITEM_ICON_COLOR',
'FROM',
'    DUAL CONNECT BY ROWNUM <= 5',
'</pre>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(55333153535517902386)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Escape special Characters'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'This value determines whether all texts that the plug-in inserts into the page should be escaped. This is necessary if texts come from user input or insecure sources to prevent XSS.'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(55333155722537902394)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_name=>'refresh-apex-notification-menu'
,p_display_name=>'Refresh Notification Menu'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6166626D2D63656E7465722D6162737B706F736974696F6E3A6162736F6C75746521696D706F7274616E743B746F703A303B6C6566743A303B626F74746F6D3A303B72696768743A303B6D617267696E3A6175746F3B746578742D616C69676E3A6365';
wwv_flow_api.g_varchar2_table(2) := '6E7465727D2E6166626D2D666C6F61747B706F736974696F6E3A66697865643B626F74746F6D3A343570783B72696768743A343570783B646973706C61793A6E6F6E653B7A2D696E6465783A3130307D2E6166626D2D666C6F61742D6C6973747B6D6172';
wwv_flow_api.g_varchar2_table(3) := '67696E3A30203020323070783B70616464696E673A3020302030203670783B6C6973742D7374796C653A6E6F6E653B6F7061636974793A303B6865696768743A303B7669736962696C6974793A68696464656E3B7472616E736974696F6E3A6F70616369';
wwv_flow_api.g_varchar2_table(4) := '747920317320656173652D6F75747D2E6166626D2D666C6F61742E69732D616374697665202E6166626D2D666C6F61742D6C6973747B7669736962696C6974793A76697369626C653B6F7061636974793A313B6865696768743A6175746F7D2E6166626D';
wwv_flow_api.g_varchar2_table(5) := '2D666C6F61742D6C6973742D6974656D7B706F736974696F6E3A72656C61746976653B77696474683A343070783B6865696768743A343070783B6D617267696E3A3135707820303B637572736F723A706F696E7465723B626F726465722D726164697573';
wwv_flow_api.g_varchar2_table(6) := '3A3530253B626F782D736861646F773A302034707820387078207267626128302C302C302C2E3235297D2E6166626D2D666C6F61742D6C6973742D6974656D3A686F7665727B2D7765626B69742D66696C7465723A677261797363616C65283130302529';
wwv_flow_api.g_varchar2_table(7) := '3B66696C7465723A677261797363616C652831303025297D2E6166626D2D666C6F61742D6C6973742D6974656D2D69636F6E7B626F726465722D7261646975733A3530253B6261636B67726F756E642D7265706561743A6E6F2D7265706561743B626163';
wwv_flow_api.g_varchar2_table(8) := '6B67726F756E642D73697A653A636F7665723B6261636B67726F756E642D706F736974696F6E3A63656E7465727D2E6166626D2D666C6F61742D6C6973742D6974656D2D6C6162656C7B706F736974696F6E3A6162736F6C7574653B746F703A3870783B';
wwv_flow_api.g_varchar2_table(9) := '72696768743A313230253B70616464696E673A347078203870783B666F6E742D73697A653A313470783B636F6C6F723A236666663B6261636B67726F756E642D636F6C6F723A233432343234323B626F726465722D7261646975733A3270783B6F706163';
wwv_flow_api.g_varchar2_table(10) := '6974793A303B77686974652D73706163653A6E6F777261703B706F696E7465722D6576656E74733A6E6F6E653B7472616E736974696F6E3A6F706163697479202E337320656173652D6F75747D2E6166626D2D666C6F61742D6C6973742D6974656D3A68';
wwv_flow_api.g_varchar2_table(11) := '6F7665723E2E6166626D2D666C6F61742D6C6973742D6974656D2D6C6162656C7B6F7061636974793A317D2E6166626D2D666C6F61742D62746E7B706F736974696F6E3A72656C61746976653B77696474683A353670783B6865696768743A353670783B';
wwv_flow_api.g_varchar2_table(12) := '666C6F61743A72696768743B6D617267696E2D72696768743A313570783B637572736F723A706F696E7465723B6261636B67726F756E642D636F6C6F723A236363633B626F726465722D7261646975733A3530253B626F782D736861646F773A31707820';
wwv_flow_api.g_varchar2_table(13) := '31707820357078207267626128302C302C302C2E34297D2E6166626D2D666C6F61742D62746E2D69636F6E7B7472616E736974696F6E3A616C6C202E34737D2E6166626D2D666C6F61742D62746E2D69636F6E2D636C6F7365647B2D7765626B69742D74';
wwv_flow_api.g_varchar2_table(14) := '72616E73666F726D3A726F746174652830293B7472616E73666F726D3A726F746174652830297D2E6166626D2D666C6F61742E69732D616374697665202E6166626D2D666C6F61742D62746E2D69636F6E2D636C6F7365647B6F7061636974793A303B2D';
wwv_flow_api.g_varchar2_table(15) := '7765626B69742D7472616E73666F726D3A726F74617465283133646567293B7472616E73666F726D3A726F7461746528313330646567297D2E6166626D2D666C6F61742D62746E2D69636F6E2D6F70656E65647B6F7061636974793A303B2D7765626B69';
wwv_flow_api.g_varchar2_table(16) := '742D7472616E73666F726D3A726F74617465282D3630646567293B7472616E73666F726D3A726F74617465282D3630646567293B7472616E73666F726D2D6F726967696E3A63656E7465722063656E7465723B746578742D616C69676E3A63656E746572';
wwv_flow_api.g_varchar2_table(17) := '7D2E6166626D2D63656E7465722D6162733E7370616E2C2E6166626D2D666C6F61742D62746E2D69636F6E2D6F70656E65643E7370616E7B6C696E652D6865696768743A353670787D2E6166626D2D666C6F61742E69732D616374697665202E6166626D';
wwv_flow_api.g_varchar2_table(18) := '2D666C6F61742D62746E2D69636F6E2D6F70656E65647B6F7061636974793A313B2D7765626B69742D7472616E73666F726D3A726F746174652830293B7472616E73666F726D3A726F746174652830297D2E6166626D2D666C6F61742D6C6973742D6974';
wwv_flow_api.g_varchar2_table(19) := '656D2D69636F6E3E7370616E7B6C696E652D6865696768743A343070787D2E6166626D2D666C6F61742D62746E2D6265666F72657B646973706C61793A666C65783B616C69676E2D6974656D733A63656E7465723B6A7573746966792D636F6E74656E74';
wwv_flow_api.g_varchar2_table(20) := '3A63656E7465723B636F6E74656E743A27273B706F736974696F6E3A6162736F6C7574653B77696474683A333270783B6865696768743A333270783B626F726465723A31707820736F6C696420236363633B6F7061636974793A303B626F726465722D72';
wwv_flow_api.g_varchar2_table(21) := '61646975733A313030253B7472616E73666F726D2D6F726967696E3A63656E7465722063656E7465723B616E696D6174696F6E3A726970706C6520312E357320656173652D6F757420696E66696E6974653B616E696D6174696F6E2D64656C61793A3073';
wwv_flow_api.g_varchar2_table(22) := '3B616E696D6174696F6E2D64656C61793A2E31733B7A2D696E6465783A2D313B746F703A313270783B6C6566743A313270787D406B65796672616D657320726970706C657B30252C3335257B7472616E73666F726D3A7363616C652830293B6F70616369';
wwv_flow_api.g_varchar2_table(23) := '74793A317D3530257B7472616E73666F726D3A7363616C652832293B6F7061636974793A2E387D313030257B6F7061636974793A303B7472616E73666F726D3A7363616C652833297D7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(27808310854423656523)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_file_name=>'afbm.pkgd.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220666C6F6174696E67427574746F6E4D656E753D66756E6374696F6E28297B2275736520737472696374223B766172206F3D7B76657273696F6E3A22312E322E35222C6973446566696E6564416E644E6F744E756C6C3A66756E6374696F6E286F';
wwv_flow_api.g_varchar2_table(2) := '297B72657475726E20766F69642030213D3D6F26266E756C6C213D3D6F7D2C6973415045583A66756E6374696F6E28297B72657475726E22756E646566696E656422213D747970656F6620617065787D2C64656275673A7B696E666F3A66756E6374696F';
wwv_flow_api.g_varchar2_table(3) := '6E286E297B6F2E69734150455828292626617065782E64656275672E696E666F286E297D2C6572726F723A66756E6374696F6E286E297B6F2E69734150455828293F617065782E64656275672E6572726F72286E293A636F6E736F6C652E6572726F7228';
wwv_flow_api.g_varchar2_table(4) := '6E297D7D2C6A736F6E53617665457874656E643A66756E6374696F6E286F2C6E297B76617220613D7B7D2C653D7B7D3B69662822737472696E67223D3D747970656F66206E297472797B653D4A534F4E2E7061727365286E297D6361746368286F297B63';
wwv_flow_api.g_varchar2_table(5) := '6F6E736F6C652E6572726F7228224572726F72207768696C652074727920746F20706172736520746172676574436F6E6669672E20506C6561736520636865636B20796F757220436F6E666967204A534F4E2E205374616E6461726420436F6E66696720';
wwv_flow_api.g_varchar2_table(6) := '77696C6C20626520757365642E22292C636F6E736F6C652E6572726F72286F292C636F6E736F6C652E6572726F72286E297D656C736520653D6E3B7472797B613D242E657874656E642821302C6F2C65297D6361746368286E297B636F6E736F6C652E65';
wwv_flow_api.g_varchar2_table(7) := '72726F7228224572726F72207768696C652074727920746F206D657267652032204A534F4E7320696E746F207374616E64617264204A534F4E20696620616E7920617474726962757465206973206D697373696E672E20506C6561736520636865636B20';
wwv_flow_api.g_varchar2_table(8) := '796F757220436F6E666967204A534F4E2E205374616E6461726420436F6E6669672077696C6C20626520757365642E22292C636F6E736F6C652E6572726F72286E292C613D6F2C636F6E736F6C652E6572726F722861297D72657475726E20617D2C6C69';
wwv_flow_api.g_varchar2_table(9) := '6E6B3A66756E6374696F6E286F2C6E297B696628216E2972657475726E2077696E646F772E6C6F636174696F6E3D6F3B77696E646F772E6F70656E286F2C225F626C616E6B22297D2C6973546F7563684465766963653A66756E6374696F6E28297B7265';
wwv_flow_api.g_varchar2_table(10) := '7475726E226F6E746F756368737461727422696E2077696E646F777D7D3B72657475726E7B696E697469616C697A653A66756E6374696F6E286E2C612C652C742C722C73297B66756E6374696F6E2069286E297B6966286E26266E2E726F7726266E2E72';
wwv_flow_api.g_varchar2_table(11) := '6F772E6C656E6774683E30297B76617220613D242864293B6F2E64656275672E696E666F286E293B76617220653D6E2E726F773B6F2E64656275672E696E666F2865293B76617220743D6E2E726F775B305D3B6F2E64656275672E696E666F2874293B76';
wwv_flow_api.g_varchar2_table(12) := '617220733D2428223C6469763E3C2F6469763E22293B732E616464436C61737328226166626D2D666C6F617422292C732E6174747228226964222C6C292C732E6373732822626F74746F6D222C742E42544E5F504F534954494F4E5F424F54544F4D7C7C';
wwv_flow_api.g_varchar2_table(13) := '662E62746E506F736974696F6E426F74746F6D292C732E63737328227269676874222C742E42544E5F504F534954494F4E5F52494748547C7C662E62746E506F736974696F6E5269676874293B76617220693D2428223C756C3E3C2F756C3E22293B692E';
wwv_flow_api.g_varchar2_table(14) := '616464436C61737328226166626D2D666C6F61742D6C69737422292C242E6561636828652C66756E6374696F6E286E2C61297B76617220653D2428223C6C693E3C2F6C693E22293B652E616464436C61737328226166626D2D666C6F61742D6C6973742D';
wwv_flow_api.g_varchar2_table(15) := '6974656D22293B76617220743D2428223C7370616E3E3C2F7370616E3E22293B742E616464436C61737328226166626D2D666C6F61742D6C6973742D6974656D2D6C6162656C22292C2131213D3D723F742E7465787428612E4954454D5F54455854293A';
wwv_flow_api.g_varchar2_table(16) := '742E68746D6C28612E4954454D5F54455854292C612E4954454D5F544558545F434F4C4F522626742E6373732822636F6C6F72222C612E4954454D5F544558545F434F4C4F52292C612E4954454D5F544558545F4241434B47524F554E442626742E6373';
wwv_flow_api.g_varchar2_table(17) := '7328226261636B67726F756E64222C612E4954454D5F544558545F4241434B47524F554E44292C652E617070656E642874292C612E4954454D5F4C494E4B2626652E6F6E2822636C69636B222C66756E6374696F6E286E297B6F2E6C696E6B28612E4954';
wwv_flow_api.g_varchar2_table(18) := '454D5F4C494E4B2C662E6C696E6B546172676574426C616E6B292C6E2E73746F7050726F7061676174696F6E28297D293B76617220733D2428223C7370616E3E3C2F7370616E3E22293B732E616464436C61737328226166626D2D666C6F61742D6C6973';
wwv_flow_api.g_varchar2_table(19) := '742D6974656D2D69636F6E22292C732E616464436C61737328226166626D2D63656E7465722D61627322293B766172206C3D226C696E6561722D6772616469656E742836306465672C2068736C28222B32332A6E253335302B222C203739252C20343525';
wwv_flow_api.g_varchar2_table(20) := '292C2068736C28222B32332A6E253335302B222C203630252C203435252929223B696628732E63737328226261636B67726F756E642D636F6C6F72222C612E4954454D5F434F4C4F527C7C6C292C6F2E6973446566696E6564416E644E6F744E756C6C28';
wwv_flow_api.g_varchar2_table(21) := '612E4954454D5F49434F4E29297B76617220643D2428223C7370616E3E3C2F7370616E3E22293B2266612D223D3D3D612E4954454D5F49434F4E2E73756273747228302C2266612D222E6C656E677468293F28642E616464436C6173732822666120222B';
wwv_flow_api.g_varchar2_table(22) := '612E4954454D5F49434F4E292C6F2E6973446566696E6564416E644E6F744E756C6C28612E4954454D5F49434F4E5F434F4C4F52292626732E6373732822636F6C6F72222C612E4954454D5F49434F4E5F434F4C4F5229293A732E63737328226261636B';
wwv_flow_api.g_varchar2_table(23) := '67726F756E642D696D616765222C2275726C28222B612E4954454D5F49434F4E2B222922292C732E617070656E642864297D652E617070656E642873292C692E617070656E642865297D292C732E617070656E642869293B76617220633D2428223C6469';
wwv_flow_api.g_varchar2_table(24) := '763E3C2F6469763E22293B696628632E616464436C61737328226166626D2D666C6F61742D62746E22292C632E63737328226261636B67726F756E64222C742E42544E5F434F4C4F527C7C662E62746E436F6C6F72292C662E726970706C654566666563';
wwv_flow_api.g_varchar2_table(25) := '74297B76617220753D2428223C6469763E3C2F6469763E22293B752E616464436C61737328226166626D2D666C6F61742D62746E2D6265666F726522292C632E70726570656E642875292C752E6373732822626F726465722D636F6C6F72222C742E4254';
wwv_flow_api.g_varchar2_table(26) := '4E5F524950504C455F434F4C4F527C7C662E62746E526970706C65436F6C6F72297D76617220703D2428223C6469763E3C2F6469763E22293B702E616464436C61737328226166626D2D666C6F61742D62746E2D69636F6E22292C702E616464436C6173';
wwv_flow_api.g_varchar2_table(27) := '7328226166626D2D666C6F61742D62746E2D69636F6E2D636C6F73656422292C702E616464436C61737328226166626D2D63656E7465722D61627322293B76617220623D2428223C7370616E3E3C2F7370616E3E22293B622E616464436C617373282266';
wwv_flow_api.g_varchar2_table(28) := '6122292C622E616464436C61737328742E42544E5F49434F4E7C7C662E62746E49636F6E292C622E616464436C617373282266612D6C6722292C622E6373732822636F6C6F72222C742E42544E5F49434F4E5F434F4C4F527C7C662E62746E49636F6E43';
wwv_flow_api.g_varchar2_table(29) := '6F6C6F72292C702E617070656E642862292C632E617070656E642870293B76617220433D2428223C6469763E3C2F6469763E22293B432E616464436C61737328226166626D2D666C6F61742D62746E2D69636F6E22292C432E616464436C617373282261';
wwv_flow_api.g_varchar2_table(30) := '66626D2D666C6F61742D62746E2D69636F6E2D6F70656E656422293B76617220763D2428223C7370616E3E3C2F7370616E3E22293B762E616464436C6173732822666122292C762E616464436C61737328742E42544E5F49434F4E5F484F5645527C7C66';
wwv_flow_api.g_varchar2_table(31) := '2E62746E49636F6E486F766572292C762E616464436C617373282266612D6C6722292C762E6373732822636F6C6F72222C742E42544E5F49434F4E5F434F4C4F527C7C662E62746E49636F6E436F6C6F72292C432E617070656E642876292C632E617070';
wwv_flow_api.g_varchar2_table(32) := '656E642843292C732E617070656E642863292C732E6F6E2822636C69636B222C66756E6374696F6E286F297B752626752E746F67676C6528292C732E746F67676C65436C617373282269732D61637469766522292C6F2E73746F7050726F706167617469';
wwv_flow_api.g_varchar2_table(33) := '6F6E28297D292C6F2E6973546F75636844657669636528293F2428646F63756D656E74292E6F6E2822746F756368737461727420636C69636B222C66756E6374696F6E286F297B732E6973286F2E746172676574297C7C30213D3D732E686173286F2E74';
wwv_flow_api.g_varchar2_table(34) := '6172676574292E6C656E6774687C7C28752626752E73686F7728292C732E72656D6F7665436C617373282269732D6163746976652229292C6F2E73746F7050726F7061676174696F6E28297D293A28732E6F6E28226D6F7573656F766572222C66756E63';
wwv_flow_api.g_varchar2_table(35) := '74696F6E286F297B752626752E6869646528292C732E616464436C617373282269732D61637469766522292C6F2E73746F7050726F7061676174696F6E28297D292C732E6F6E28226D6F7573656F7574222C66756E6374696F6E286F297B752626752E73';
wwv_flow_api.g_varchar2_table(36) := '686F7728292C732E72656D6F7665436C617373282269732D61637469766522292C6F2E73746F7050726F7061676174696F6E28297D29292C242822626F647922292E617070656E642873292C612E666164654F7574283165332C66756E6374696F6E2829';
wwv_flow_api.g_varchar2_table(37) := '7B242E6561636828612C66756E6374696F6E286F2C6E297B6E2E72656D6F766528297D297D292C732E66616465496E28316533297D7D766172206C3D6E7C7C226166626D222C643D2223222B6C2C633D7B726566726573683A302C62746E49636F6E3A22';
wwv_flow_api.g_varchar2_table(38) := '66612D706C7573222C62746E49636F6E486F7665723A2266612D636C6F7365222C62746E436F6C6F723A2223463434333336222C62746E526970706C65436F6C6F723A2223463434333336222C62746E49636F6E436F6C6F723A227768697465222C6274';
wwv_flow_api.g_varchar2_table(39) := '6E506F736974696F6E426F74746F6D3A2234357078222C62746E506F736974696F6E52696768743A2234357078222C6C696E6B546172676574426C616E6B3A21302C726970706C654566666563743A21307D3B696628652976617220663D6F2E6A736F6E';
wwv_flow_api.g_varchar2_table(40) := '53617665457874656E6428632C65293B656C736520663D633B6966287329692873293B656C73657B66756E6374696F6E2075286E297B617065782E7365727665722E706C7567696E28612C7B706167654974656D733A747D2C7B737563636573733A6675';
wwv_flow_api.g_varchar2_table(41) := '6E6374696F6E286F297B6E286F297D2C6572726F723A66756E6374696F6E286E297B6F2E64656275672E6572726F7228224572726F72207768696C652074727920746F206C6F616420646174612122292C6F2E64656275672E6572726F72286E2E726573';
wwv_flow_api.g_varchar2_table(42) := '706F6E736554657874297D2C64617461547970653A226A736F6E227D297D696628752869292C662E726566726573683E30297B76617220703B703D736574496E74657276616C2866756E6374696F6E28297B303D3D3D242864292E6C656E6774683F636C';
wwv_flow_api.g_varchar2_table(43) := '656172496E74657276616C2870293A286F2E64656275672E696E666F282252656672657368206576656E742077617320666972656422292C75286929297D2C3165332A662E72656672657368297D7D7D7D7D28293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(27808311144740656524)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_file_name=>'afbm.pkgd.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '4D4954204C6963656E73650A0A436F7079726967687420286329203230323020526F6E6E792057656973730A0A5065726D697373696F6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E79207065';
wwv_flow_api.g_varchar2_table(2) := '72736F6E206F627461696E696E67206120636F70790A6F66207468697320736F66747761726520616E64206173736F63696174656420646F63756D656E746174696F6E2066696C657320287468652022536F66747761726522292C20746F206465616C0A';
wwv_flow_api.g_varchar2_table(3) := '696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E6720776974686F7574206C696D69746174696F6E20746865207269676874730A746F207573652C20636F70792C206D6F646966792C206D';
wwv_flow_api.g_varchar2_table(4) := '657267652C207075626C6973682C20646973747269627574652C207375626C6963656E73652C20616E642F6F722073656C6C0A636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F20';
wwv_flow_api.g_varchar2_table(5) := '77686F6D2074686520536F6674776172652069730A6675726E697368656420746F20646F20736F2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0A0A5468652061626F766520636F70797269676874206E';
wwv_flow_api.g_varchar2_table(6) := '6F7469636520616E642074686973207065726D697373696F6E206E6F74696365207368616C6C20626520696E636C7564656420696E20616C6C0A636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674';
wwv_flow_api.g_varchar2_table(7) := '776172652E0A0A54484520534F4654574152452049532050524F564944454420224153204953222C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520A494D504C4945442C20494E434C5544494E47';
wwv_flow_api.g_varchar2_table(8) := '20425554204E4F54204C494D4954454420544F205448452057415252414E54494553204F46204D45524348414E544142494C4954592C0A4649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E465249';
wwv_flow_api.g_varchar2_table(9) := '4E47454D454E542E20494E204E4F204556454E54205348414C4C205448450A415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F544845';
wwv_flow_api.g_varchar2_table(10) := '520A4C494142494C4954592C205748455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0A4F5554204F46204F5220494E20434F4E4E454354';
wwv_flow_api.g_varchar2_table(11) := '494F4E20574954482054484520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450A534F4654574152452E0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(55448900590145032493)
,p_plugin_id=>wwv_flow_api.id(55333151726598902381)
,p_file_name=>'LICENSE'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
