<?php
class block_academymarquee extends block_base
{

	function init()
	{
		$this->title = get_string('pluginname', 'block_academymarquee');
	}
	function has_config()
	{
		return true;
	}
	function hide_header()
	{
		return true;
	}
	public function applicable_formats()
	{
		return array('my' => true);
	}
	public function instance_allow_multiple()
	{
		return false;
	}
	function get_content()
	{
		global $DB, $USER;
		if ($this->content !== NULL) {
			return $this->content;
		}
		$userCohorts = [];
		foreach ($USER->userselectors as $userselector) {
			if (!in_array($userselector["cohortid"], $userCohorts)) array_push($userCohorts, $userselector["cohortid"]);
		};
		$cohorts = $DB->get_records_sql('SELECT cohortid FROM {cohort_members} WHERE userid=?', array($USER->id));
		$messagesHtml = '';
		foreach ($cohorts as $cohort) {
			$messagesHtml .= get_config('block_marquee_cohort', 'cohort_' . $cohort->cohortid);
		}
		$this->content = new stdClass;
		$this->content->text = $messagesHtml;
		return $this->content;
	}
}
