import glob
include: "rules/liftover.smk"
SAMPLES=[]

sample_id_list = glob.glob('vcf/*.vcf.gz')
for name in sample_id_list:
    SAMPLES.append(name.split('.')[0].split('/')[1])


rule all:
    input:
        vcf_filtre = expand(
                        "results/{sample}.vcf",
                        sample = SAMPLES
                    )
    message:
        "Finishig filter pipeline"