<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

{def $new_msg = pm_message_check("inbox", "0")
	 $requests = count(pm_relation_fetch($current_user.contentobject_id, '0', 'all'))
	 $friends_on = count(pm_relation_fetch($current_user.contentobject_id, '1', 'online'))
}
<div class="pm_menu">
	<h2>{'Private Messaging'|i18n('extension/xrowpm')}</h2>
	<ul class="menu-list">
		<li>
			<div class="second_level_menu">
				<a href="/pm/inbox">
					{'Inbox'|i18n('extension/xrowpm')}
					{if $new_msg|gt(0)}
						(<strong>{$new_msg}</strong>/{pm_message_check("inbox", 1)})
					{else}
						({pm_message_check("inbox", 1)})
					{/if}
				</a>
			</div>
		</li>
		<li>
			<div class="second_level_menu">
				<a href="/pm/outbox">
					{'Sentbox'|i18n('extension/xrowpm')}
					({pm_message_check("outbox", "")})
				</a>
			</div>
		</li>
		<li>
			<div class="second_level_menu">
				<a href="/pm/network">{'my Network'|i18n('extension/xrowpm')}
					{if and($requests|gt(0), $friends_on|gt(0))}
						<strong>{$requests} {'request(s)'|i18n('extension/xrowpm')} / {$friends_on} {'online'|i18n('extension/xrowpm')} </strong>
					{elseif $requests|gt(0)}
						(<strong>{$requests} {'request(s)'|i18n('extension/xrowpm')} </strong>)
					{elseif $friends_on|gt(0)}
						<strong>{$friends_on} {'online'|i18n('extension/xrowpm')} </strong>
					{/if}
				</a>
			</div>
		</li>
		<li><div class="second_level_menu"><a href="/pm/create">{'New Message'|i18n('extension/xrowpm')}</a></div></li>
	</ul>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>