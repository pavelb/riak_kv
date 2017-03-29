%% -------------------------------------------------------------------
%%
%% riak_kv_iterable_backend: Behaviour for backends that can be iterated over
%%
%% Copyright (c) 2017 Basho Technologies, Inc.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(riak_kv_iterable_backend).

-type db_ref() :: term().
-type itr_ref() :: term().
-type itr_options() :: proplists:proplist().
-type iterator_action() :: first | last | next | prev | prefetch | prefetch_stop | binary().

-callback iterator_open(DbRef::db_ref(), ItrOpts::itr_options()) -> itr_ref().
-callback iterator_open(DbRef::db_ref(), ItrOpts::itr_options(), keys_only) -> itr_ref().

-callback iterator_close(ItrRef::itr_ref()) -> ok.

-callback iterator_move(ItrRef::itr_ref(), ItrAction::iterator_action()) ->
    {ok, Key::binary(), Value::binary()} |
    {ok, Key::binary()} |
    {error, invalid_iterator} |
    {error, iterator_closed}.
