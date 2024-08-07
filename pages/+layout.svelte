<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';
	export let data;
</script>

<EvidenceDefaultLayout {data} githubRepo=https://github.com/archiewood/bls logo=/bls.png>
	<slot slot="content" />
</EvidenceDefaultLayout>
