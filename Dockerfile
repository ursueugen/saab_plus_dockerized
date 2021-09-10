FROM python:2.7

WORKDIR /home/SAAB_PLUS_SOURCE

# Install HMMER v3
RUN wget "http://eddylab.org/software/hmmer/hmmer.tar.gz" \
	    && gunzip hmmer.tar.gz \
	    && tar -xvf hmmer.tar \
	    && cd hmmer-3.3.2 \
	    && ./configure \
	    && make install \
	    && cd ..


# Install SCALOP
RUN curl -X POST \
	    -F "email=eugen.ursu@biochim.ro" \
	    -F "institution=Institute of Biochemistry of Romanian Academy, Bucharest, Romania" \
	    "http://opig.stats.ox.ac.uk/webapps/newsabdab/sabpred/scalop" \
	    --output "scalop-1.0.tar"
RUN tar -xvf scalop-1.0.tar \
	    && cd scalop-1.0 \
	    && python setup.py install \
	    && cd ..

# Install ANARCI
RUN curl -X POST \
	    -F "email=eugen.ursu@biochim.ro" \
	    -F "institution=Institute of Biochemistry of Romanian Academy, Bucharest, Romania" \
	    "http://opig.stats.ox.ac.uk/webapps/newsabdab/sabpred/anarci/" \
	    --output "anarci-1.3.tar"
RUN tar -xvf anarci-1.3.tar \
	    && cd anarci-1.3 \
	    && python setup.py install \
	    && cd ..

# Install SAAB_PLUS
RUN git clone "https://github.com/oxpig/saab_plus.git" \
	    && cd saab_plus \
	    && pip install -r requirements.txt \
	    && python setup.py install \
	    && cd ..

WORKDIR /home/SAAB_PLUS
CMD ["SAAB_PLUS"]
