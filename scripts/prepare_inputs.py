import json
import sys, os

fname = sys.argv[1]
myinputs = json.loads(open(fname,'rt').read())
if not os.path.exists('mytempdir'): os.mkdir('mytempdir')
for sample_name in myinputs:
    fnames = myinputs[sample_name]
    if len(fnames) == 2:
        sys.stderr.write(fnames[0]+"\n")
        os.symlink(fnames[0],'mytempdir/'+sample_name+'_R1_001.fastq.gz')
        sys.stderr.write(fnames[1]+"\n")
        os.symlink(fnames[1],'mytempdir/'+sample_name+'_R2_001.fastq.gz')
    else:
        sys.stderr.write(fnames[0]+"\n")
        os.symlink(fnames[0],'mytempdir/'+sample_name+'.fastq.gz')
