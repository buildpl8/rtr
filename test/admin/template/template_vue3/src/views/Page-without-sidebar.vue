<script>
import { useAppOptionStore } from '@/stores/app-option';
import highlightjs from '@/components/plugins/Highlightjs.vue';
import axios from 'axios';

const appOption = useAppOptionStore();

export default {
	data () {
		return {
			code1: ''
		}
	},
	components: {
		highlightjs: highlightjs
	},
	mounted() {
		appOption.appSidebarHide = true;
		
		axios.get('/assets/data/page-option/without-sidebar.json').then((response) => {
			this.code1 = response.data;
		});
	},
	beforeRouteLeave (to, from, next) {
		appOption.appSidebarHide = false;
		next();
	}
}
</script>
<template>
	<div>
		<!-- BEGIN breadcrumb -->
		<ol class="breadcrumb float-xl-end">
			<li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
			<li class="breadcrumb-item"><a href="javascript:;">Page Options</a></li>
			<li class="breadcrumb-item active">Page without Sidebar</li>
		</ol>
		<!-- END breadcrumb -->
		<!-- BEGIN page-header -->
		<h1 class="page-header">Page without Sidebar <small>header small text goes here...</small></h1>
		<!-- END page-header -->
		
		<!-- BEGIN panel -->
		<panel>
			<panel-header>
				<panel-title>Installation Settings</panel-title>
				<panel-toolbar />
			</panel-header>
			<panel-body>
				<p>
					Add the following app settings to the <code>page.vue</code> that you wish to change 
					<b>OR</b> change it from <code>/stores/app-option.ts</code> to make it affected to the whole app.
				</p>
			</panel-body>
			<!-- BEGIN hljs-wrapper -->
			<highlightjs :code="code1" />
		</panel>
		<!-- END panel -->

		<p>
			<a href="javascript:history.back(-1);" class="btn btn-success">
				<i class="fa fa-arrow-circle-left"></i> Back to previous page
			</a>
		</p>
	</div>
</template>