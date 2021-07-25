<?php

$cohorts = $DB->get_records('cohort', null, null, 'id, name');
foreach ($cohorts as $cohort) {
	$id = $cohort->id;
	$settings->add(new admin_setting_confightmleditor(
		"block_marquee_cohort/cohort_$id",
		$cohort->name,
		'',
		'',
	));
}
