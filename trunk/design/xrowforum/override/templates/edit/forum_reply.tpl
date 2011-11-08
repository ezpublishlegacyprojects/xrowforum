{* Forum reply - Edit *}
{def $bbcodes = ezini('BB-Codes','BBCodeList','xrowforum.ini')}

{literal}
<script language="JavaScript" type="text/javascript">
<!--

// Startup variables
var imageTag = false;
var theSelection = false;


var clientPC = navigator.userAgent.toLowerCase(); // Get client info
var clientVer = parseInt(navigator.appVersion); // Get browser version

var is_ie = ((clientPC.indexOf("msie") != -1) && (clientPC.indexOf("opera") == -1));
var is_nav  = ((clientPC.indexOf('mozilla')!=-1) && (clientPC.indexOf('spoofer')==-1)
                && (clientPC.indexOf('compatible') == -1) && (clientPC.indexOf('opera')==-1)
                && (clientPC.indexOf('webtv')==-1) && (clientPC.indexOf('hotjava')==-1));
var is_moz = 0;

var is_win   = ((clientPC.indexOf("win")!=-1) || (clientPC.indexOf("16bit") != -1));
var is_mac    = (clientPC.indexOf("mac")!=-1);



// Define the bbCode tags
bbcode = new Array();
bbtags = new Array('[b]','[/b]','[i]','[/i]','[u]','[/u]','[quote]','[/quote]','[code]','[/code]','[list]','[/list]','<strike> ','</strike>','[img]','[/img]','[url]','[/url]');
imageTag = false;


// Replacement for arrayname.length property
function getarraysize(thearray) {
    for (i = 0; i < thearray.length; i++) {
        if ((thearray[i] == "undefined") || (thearray[i] == "") || (thearray[i] == null))
            return i;
        }
    return thearray.length;
}

// Replacement for arrayname.push(value) not implemented in IE until version 5.5
// Appends element to the array
function arraypush(thearray,value) {
    thearray[ getarraysize(thearray) ] = value;
}

// Replacement for arrayname.pop() not implemented in IE until version 5.5
// Removes and returns the last element of an array
function arraypop(thearray) {
    thearraysize = getarraysize(thearray);
    retval = thearray[thearraysize - 1];
    delete thearray[thearraysize - 1];
    return retval;
}

function emoticon(text) {
        var txtarea = document.getElementById('Topic_Content').childNodes[3];
        text = ' ' + text + ' ';
        if (txtarea.createTextRange && txtarea.caretPos) {
                var caretPos = txtarea.caretPos;
                caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == ' ' ? caretPos.text + text + ' ' : caretPos.text + text;
                txtarea.focus();
        } else {
                txtarea.value  += text;
                txtarea.focus();
    }
}

function bbfontstyle(bbopen, bbclose) {
    var txtarea = document.getElementById('Topic_Content').childNodes[3];
    if ((clientVer >= 4) && is_ie && is_win) {
        theSelection = document.selection.createRange().text;
        if (!theSelection) {
            document.post.message.value += bbopen + bbclose;
            document.post.message.focus();
            return;
        }
        document.selection.createRange().text = bbopen + theSelection + bbclose;
        txtarea.focus();
        return;
    }
    else if (txtarea.selectionEnd && (txtarea.selectionEnd - txtarea.selectionStart > 0))
    {
    mozWrap(txtarea, bbopen, bbclose);
    return;
    }
    else
    {
    txtarea.value += bbopen + bbclose;
    txtarea.focus();
    }
    storeCaret(txtarea);
}


function bbstyle(bbnumber) {

    var txtarea = document.getElementById('Topic_Content').childNodes[3];
    txtarea.focus();
    donotinsert = false;
    theSelection = false;
    bblast = 0;

    if (bbnumber == -1) { // Close all open tags & default button names
        while (bbcode[0]) {
            butnumber = arraypop(bbcode) - 1;
            txtarea.value += bbtags[butnumber + 1];
            buttext = eval('document.post.addbbcode' + butnumber + '.value');
            eval('document.post.addbbcode' + butnumber + '.value ="' + buttext.substr(0,(buttext.length - 1)) + '"');
        }
        imageTag = false; // All tags are closed including image tags :D
        txtarea.focus();
        return;
    }

    if ((clientVer >= 4) && is_ie && is_win)
        {
  theSelection = document.selection.createRange().text; // Get text selection

    if (theSelection) {
        // Add tags around selection
        document.selection.createRange().text = bbtags[bbnumber] + theSelection + bbtags[bbnumber+1];
        txtarea.focus();
        theSelection = '';
        return;
    }
        }
                else if (txtarea.selectionEnd && (txtarea.selectionEnd - txtarea.selectionStart > 0))
                {
                                mozWrap(txtarea, bbtags[bbnumber], bbtags[bbnumber+1]);
                                return;
                 }

    // Find last occurance of an open tag the same as the one just clicked
    for (i = 0; i < bbcode.length; i++) {
        if (bbcode[i] == bbnumber+1) {
            bblast = i;
            donotinsert = true;
        }
    }

    if (donotinsert) {      // Close all open tags up to the one just clicked & default button names
        while (bbcode[bblast]) {
                butnumber = arraypop(bbcode) - 1;
                txtarea.value += bbtags[butnumber + 1];
                buttext = eval('document.post.addbbcode' + butnumber + '.value');
                eval('document.post.addbbcode' + butnumber + '.value ="' + buttext.substr(0,(buttext.length - 1)) + '"');
                imageTag = false;
            }
            txtarea.focus();
            return;
    } else { // Open tags

        if (imageTag && (bbnumber != 14)) {     // Close image tag before adding another
            txtarea.value += bbtags[15];
            lastValue = arraypop(bbcode) - 1;   // Remove the close image tag from the list
            document.post.addbbcode14.value = "Img";    // Return button back to normal state
            imageTag = false;
        }

        // Open tag
        txtarea.value += bbtags[bbnumber];
        if ((bbnumber == 14) && (imageTag == false)) imageTag = 1; // Check to stop additional tags after an unclosed image tag
        arraypush(bbcode,bbnumber+1);
        eval('document.post.addbbcode'+bbnumber+'.value += "*"');
        txtarea.focus();
                                return;
                }
                storeCaret(txtarea);
   }

   function mozWrap(txtarea, open, close)
   {
                var selLength = txtarea.textLength;
                var selStart = txtarea.selectionStart;
                var selEnd = txtarea.selectionEnd;
                if (selEnd == 1 || selEnd == 2)
                                selEnd = selLength;

                var s1 = (txtarea.value).substring(0,selStart);
                var s2 = (txtarea.value).substring(selStart, selEnd)
                var s3 = (txtarea.value).substring(selEnd, selLength);
                txtarea.value = s1 + open + s2 + close + s3;
                return;
}

function storeCaret(textEl) {
    if (textEl.createTextRange) textEl.caretPos = document.selection.createRange().duplicate();
}

//-->
</script>
{/literal}

<div class="edit">
    <div class="class-forum-reply">
                <form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>
                    
					<h1>{"Edit %1 - %2"|i18n("extension/xrowforum",,array($class.name|wash,$object.name|wash))}</h1>
					
                    {include uri="design:content/edit_validation.tpl"}
                    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
                    
                    {section var=attributes loop=$content_attributes}
                        {if not($attributes.contentclass_attribute.identifier|eq('message'))}
                            <div class="block ezcca-edit-datatype-{$attributes.item.data_type_string} ezcca-edit-{$attributes.item.contentclass_attribute_identifier}">
                                <label{if $attributes.item.has_validation_error} class="message-error"{/if}>{$attributes.item.contentclass_attribute_name|wash}{if $attributes.item.is_required} <span class="required">({'Required'|i18n( 'extension/xrowforum' )})</span>{/if}{if $attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'extension/xrowforum' )})</span>{/if}:</label>
                                {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
                                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
                            </div>
                        {else}
                            <div id="java_editor" class="block">
                                <table width="450" border="0" cellspacing="0" cellpadding="2">
                                    <tr>
                                        {if $bbcodes.big|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="b" name="addbbcode0" value=" B "onClick="bbstyle(0)" />
                                            </td>
                                        {/if}
                                        {if $bbcodes.italic|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="i" name="addbbcode2" value=" i "onClick="bbstyle(2)"  />
                                            </td>
                                        {/if}
                                        {if $bbcodes.underline|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="u" name="addbbcode4" value=" u " onClick="bbstyle(4)"  />
                                            </td>
                                        {/if}
                                        {if $bbcodes.quote|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="q" name="addbbcode6" value="Quote" onClick="bbstyle(6)" />
                                            </td>
                                        {/if}
                                        {if $bbcodes.code|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="c" name="addbbcode8" value="Code" onClick="bbstyle(8)"  />
                                            </td>
                                        {/if}
                                        {if $bbcodes.list|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="l" name="addbbcode10" value="List" onClick="bbstyle(10)"  />
                                            </td>
                                        {/if}
                                        {if $bbcodes.strike|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="o" name="addbbcode12" value="Strike" onClick="bbstyle(12)" />
                                            </td>
                                        {/if}
                                        {if $bbcodes.img|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="p" name="addbbcode14" value="Img" onClick="bbstyle(14)"  />
                                            </td>
                                        {/if}
                                        {if $bbcodes.url|eq('enabled')}
                                            <td>
                                                <input type="button" class="button" accesskey="w" name="addbbcode16" value="URL" onClick="bbstyle(16);"  />
                                            </td>
                                        {/if}
                                        {if $bbcodes.fontcolor|eq('enabled')}
                                            <td>
                                                <select name="addbbcode18" onChange="bbfontstyle('[color=' + this.form.addbbcode18.options[this.form.addbbcode18.selectedIndex].value + ']', '[/color]');this.selectedIndex=0;" >
                                                    <option style="color:black;" value="#444444">Default</option>
                                                    <option style="color:darkred;"  value="darkred">Dark Red</option>
                                                    <option style="color:red;" value="red">Red</option>
                                                    <option style="color:orange;" value="orange">Orange</option>
                                                    <option style="color:brown;" value="brown">Brown</option>
                                                    <option style="color:yellow;" value="yellow">Yellow</option>
                                                    <option style="color:green;" value="green">Green</option>
                                                    <option style="color:olive;" value="olive">Olive</option>
                                                    <option style="color:cyan;" value="cyan">Cyan</option>
                                                    <option style="color:blue;" value="blue">Blue</option>
                                                    <option style="color:darkblue;" value="darkblue">Dark Blue</option>
                                                    <option style="color:indigo;" value="indigo">Indigo</option>
                                                    <option style="color:violet;" value="violet">Violet</option>
                                                    <option style="color:white;" value="white">White</option>
                                                    <option style="color:black;" value="black">Black</option>
                                                </select>
                                            </td>
                                        {/if}
                                        {if $bbcodes.fontsize|eq('enabled')}
                                            <td>
                                                <select name="addbbcode20" onChange="bbfontstyle('[size=' + this.form.addbbcode20.options[this.form.addbbcode20.selectedIndex].value + ']', '[/size]');this.selectedIndex=0;" >
                                                    <option value="0">Font size</option>
                                                    <option value="7">Tiny</option>
                                                    <option value="9">Small</option>
                                                    <option value="12">Normal</option>
                                                    <option value="18">Large</option>
                                                    <option value="24">Huge</option>
                                                </select>
                                            </td>
                                        {/if}
                                    </tr>
                                </table>
                            </div>
                            {*if u change the html child structure of "Topic_Content" then the JS will be destroyed *}
                            <div id="Topic_Content" class="block ezcca-edit-datatype-{$attributes.item.data_type_string} ezcca-edit-{$attributes.item.contentclass_attribute_identifier}">
                                <label{if $attributes.item.has_validation_error} class="message-error"{/if}>{$attributes.item.contentclass_attribute_name|wash}{if $attributes.item.is_required} <span class="required">({'Required'|i18n( 'extension/xrowforum' )})</span>{/if}{if $attributes.item.is_information_collector} <span class="collector">({'Information collector'|i18n( 'extension/xrowforum' )})</span>{/if}:</label>
                                {attribute_edit_gui attribute_base=$attribute_base attribute=$attributes.item}
                                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attributes.item.id}" />
                            </div>
                            {if $bbcodes.smilies|eq('enabled')}
                                <div id="smiley_box">
                                    <ul>
                                       {* INFOS TO ADD NEW SMILIES: the emoticon texts inside the brackets need to be the same as the test in wordtoimage in so it can be replaced by an image *}
                                        <li><a href="javascript:emoticon(';)')"><img id="blunk_smiley" src={"smilies/blunk.gif"|ezimage()} alt="wink" title="wink" /></a></li>
                                        <li><a href="javascript:emoticon(':@')"><img id="mad_smiley" src={"smilies/mad.gif"|ezimage()} alt="mad" title="mad" /></a></li>
                                        <li><a href="javascript:emoticon(':|')"><img id="confused_smiley" src={"smilies/confused.gif"|ezimage()} alt="ohnoes" title="ohnoes" /></a></li>
                                        <li><a href="javascript:emoticon(':o')"><img id="omg_smiley" src={"smilies/omg.gif"|ezimage()} alt="oha" title="oha" /></a></li>
                                        <li><a href="javascript:emoticon(':-/')"><img id="suspicious_smiley" src={"smilies/suspicious.gif"|ezimage()} alt="suspicious" title="suspicious" /></a></li>
                                        <li><a href="javascript:emoticon(':D')"><img id="big-smile_smiley" src={"smilies/big-smile.gif"|ezimage()} alt="happy" title="happy" /></a></li>
                                        <li><a href="javascript:emoticon(':(')"><img id="sad_smiley" src={"smilies/sad.gif"|ezimage()} alt="sad" title="sad" /></a></li>
                                        <li><a href="javascript:emoticon(':)')"><img id="happy_smiley" src={"smilies/happy.gif"|ezimage()} alt="happy" title="happy" /></a></li>
                                    </ul>
                                </div>
                            {/if}
                        {/if}
                    {/section}
                    
                    <div class="float-break"></div>
                    <div class="buttonblock">
                        <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('extension/xrowforum')}" />
                        <input class="defaultbutton" type="submit" name="DiscardButton" value="{'Discard'|i18n('extension/xrowforum')}" />
                        <input type="hidden" name="DiscardConfirm" value="0" />
                        {if ezhttp_hasvariable( 'RedirectURIAfterPublish', 'session' )}
							{def $redirectme=ezhttp('RedirectURIAfterPublish', 'session')}
							<input type="hidden" name="RedirectURIAfterPublish" value="{$redirectme}" />
							<input type="hidden" name="RedirectIfDiscarded" value="{$redirectme}" />
						{/if}
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>